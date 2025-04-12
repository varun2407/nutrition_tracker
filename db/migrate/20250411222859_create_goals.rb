class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.integer :calories, null: false, default: 0
      t.integer :carbs, null: false, default: 0
      t.integer :protein, null: false, default: 0
      t.integer :fat, null: false, default: 0
      t.timestamps
    end
  end
end
