class CreateWeights < ActiveRecord::Migration[8.0]
  def change
    create_table :weights do |t|
      t.decimal :weight, precision: 5, scale: 2, null: false
      t.date :measured_at, null: false
      t.timestamps
    end
  end
end
