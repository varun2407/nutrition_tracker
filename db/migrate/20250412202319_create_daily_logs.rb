class CreateDailyLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_logs do |t|
      t.references :profile, null: false, foreign_key: true
      t.date :date, null: false
      t.timestamps
    end
  end
end
