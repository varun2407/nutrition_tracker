class AddMeasurementTypeToFoods < ActiveRecord::Migration[8.0]
  def change
    add_column :foods, :measurement_type, :string, default: 'weight'
    add_column :foods, :unit, :string, default: 'g'
  end
end
