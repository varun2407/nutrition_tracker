class CreateFoodEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :food_entries do |t|
      t.references :daily_log, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :meal_type
      t.references :food, null: false, foreign_key: true
      t.timestamps
    end
  end
end
