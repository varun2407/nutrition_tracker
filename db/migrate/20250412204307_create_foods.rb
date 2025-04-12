class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.integer :calories, null: false
      t.timestamps
    end
  end
end
