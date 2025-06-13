class NutritionAssistant
  require "ollama-ai"
  require "httparty"
  require "openfoodfacts"

  def initialize(user)
    @user = user
    @llm_client = Ollama.new(
      credentials: { address: "http://localhost:11434" },
      options: { server_sent_events: true }
    )
  end

  def parse_user_input(input)
    prompt = <<~PROMPT
      Extract food items from the following input:
      "#{input}"
      Return the result as a JSON array of strings.
    PROMPT

    response = @llm_client.generate(model: "llama2", prompt: prompt)
    JSON.parse(response.map { |r| r["response"] }.join(""))
  rescue JSON::ParserError
    []
  end

  def query_open_foods_api(food_item)
    products = Openfoodfacts::Product.search(food_item, locale: "world")
    return nil if products.empty?

    product = products.first # Use the first product as an example
    {
      name: product["product_name"],
      brands: product["brands"]&.split(", "),
      calories: product["nutriments"]["energy-kcal_100g"],
      carbs: product["nutriments"]["carbohydrates_100g"],
      protein: product["nutriments"]["proteins_100g"],
      fat: product["nutriments"]["fat_100g"]
    }
  rescue StandardError => e
    Rails.logger.error("Error querying OpenFoodFacts: #{e.message}")
    nil
  end

  def generate_follow_up_question(data)
    if data[:brands].size > 1
      "Multiple brands found for #{data[:name]}. Please select one: #{data[:brands].join(', ')}."
    elsif data[:meal_type].nil?
      "What meal type is this for? (e.g., Breakfast, Lunch, Dinner, Snacks)"
    else
      nil
    end
  end


  def save_meal_details(meal_data)
    daily_log = @user.daily_logs.find_or_create_by(date: Date.today)
    food = Food.find_or_create_by(name: meal_data[:name]) do |f|
      f.calories = meal_data[:calories]
      f.carbs = meal_data[:carbs]
      f.protein = meal_data[:protein]
      f.fat = meal_data[:fat]
    end

    daily_log.food_entries.create!(
      food: food,
      quantity: meal_data[:quantity],
      meal_type: meal_data[:meal_type]
    )
  end

  def respond_to_user(message)
    Rails.logger.info("Response to user: #{message}")
    message
  end

  def handle_user_input(input)
    food_items = parse_user_input(input)
    return respond_to_user("No food items found in your input.") if food_items.empty?

    food_items.each do |food_item|
      api_data = query_open_foods_api(food_item)
      next respond_to_user("Could not find details for #{food_item}.") unless api_data

      follow_up = generate_follow_up_question(api_data)
      if follow_up
        return respond_to_user(follow_up)
      else
        save_meal_details(api_data)
        respond_to_user("#{food_item} has been logged successfully.")
      end
    end
  end
end
