class AddUserAndNotesToWeights < ActiveRecord::Migration[8.0]
  def change
    add_reference :weights, :user, null: false, foreign_key: true
    add_column :weights, :notes, :text
  end
end
