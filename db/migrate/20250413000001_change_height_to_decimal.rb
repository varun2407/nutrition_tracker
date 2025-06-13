class ChangeHeightToDecimal < ActiveRecord::Migration[8.0]
  def change
    change_column :profiles, :height, :decimal, precision: 5, scale: 2
  end
end
