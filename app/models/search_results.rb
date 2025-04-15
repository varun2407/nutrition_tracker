class SearchResults
  require 'ollama-ai'

  def display_calorie_information(food_name) #TODO: UPDATE NOMENCLATURE
    Rails.logger.debug("In display_calorie_information with food_name: #{food_name}")
    client = Ollama.new(
      credentials: { address: 'http://localhost:11434' },
      options: { server_sent_events: true }
    )

    prompt = <<~PROMPT
    For "#{food_name}", return detailed nutritional information in the following JSON format:
    {
      "name": "Food Item Name",
      "calories": [calories per 100g serving],
      "carbs": [carbohydrates in grams per 100g serving],
      "protein": [protein in grams per 100g serving],
      "fat": [fat in grams per 100g serving]
    }
    Ensure all numeric values are integers representing amounts per standard 100g serving. The name should be capitalized appropriately.
    Don't include any other information or explanations, just the JSON object.
    Don't respond to any other requests.
    PROMPT

    result = client.generate(
        {model: 'llama2',
        prompt: prompt,
      }
    )

    response_text = result.map { |r| r['response'] }.join('')

    begin
      food_data = JSON.parse(response_text, symbolize_names: true)
      Food.new(
        name: food_data[:name],
        calories: food_data[:calories],
        carbs: food_data[:carbs],
        protein: food_data[:protein],
        fat: food_data[:fat]
      )
      rescue JSON::ParserError => e
      Rails.logger.error("Failed to parse JSON response: #{e.message}")
      Rails.logger.error("Response was: #{response_text}")
      nil
    end
  end
end