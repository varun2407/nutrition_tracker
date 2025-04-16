# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"

# Clear out data with proper order to maintain referential integrity
puts "Clearing existing food entries..."
FoodEntry.destroy_all

puts "Clearing existing foods..."
Food.destroy_all

puts "Loading food data from JSON file..."
foods_data = JSON.parse(File.read(Rails.root.join('db/foods.json')), symbolize_names: true)

foods_data.each do |food_data|
  Food.create!(
    name: food_data[:name],
    calories: food_data[:calories],
    carbs: food_data[:carbs],
    protein: food_data[:protein],
    fat: food_data[:fat]
  )
end

puts "Successfully created #{Food.count} food items"
puts "Seed completed successfully!"
