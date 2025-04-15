class SearchResults
  require 'ollama-ai'

  def display_calorie_information(food_name)
    Rails.logger.debug("In display_calorie_information with food_name: #{food_name}")
    client = Ollama.new(
      credentials: { address: 'http://localhost:11434' },
      options: { server_sent_events: true }
    )

    prompt = <<~PROMPT
      For "#{food_name}", provide accurate nutritional information in this JSON format:
      {
        "name": "Food Item Name",
        "calories": [calories per 100g serving],
        "carbs": [carbohydrates in grams per 100g serving],
        "protein": [protein in grams per 100g serving],
        "fat": [fat in grams per 100g serving]
      }

      Instructions:
      1. Use standard USDA nutritional database values where possible.
      2. Convert all values to represent a standard 100g serving.
      3. Round all numeric values to the nearest integer.
      4. Return ONLY the JSON object with no additional text, explanations, or commentary.
      5. Do not include any notes, disclaimers, or introductory text.

      IMPORTANT: Return ONLY the JSON object with no additional text before or after.
      Do not include any introduction like "Here is" or "Sure!".
      Your entire response must start with { and end with } and be valid JSON
    PROMPT

    result = client.generate(
        {model: 'llama2',
        prompt: prompt,
      }
    )

    response_text = result.map { |r| r['response'] }.join('')
    Rails.logger.debug("Response from Ollama: #{response_text}")

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