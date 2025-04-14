class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.date :birth_date
      t.integer :height
      t.timestamps
    end
  end
end
