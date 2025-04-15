class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.integer :calories, null: false
      t.integer :carbs, null: false
      t.integer :protein, null: false
      t.integer :fat, null: false
      t.timestamps
    end

    add_index :foods, :name, unique: true
  end
end
