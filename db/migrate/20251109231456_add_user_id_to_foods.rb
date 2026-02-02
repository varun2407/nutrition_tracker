class AddUserIdToFoods < ActiveRecord::Migration[8.0]
  def change
    add_column :foods, :user_id, :bigint, null: true
    add_index :foods, :user_id
    add_foreign_key :foods, :users

    # Remove the unique constraint on name since users can have custom foods with same names
    # We'll rely on application-level validation for uniqueness scoped to user_id
    remove_index :foods, :name if index_exists?(:foods, :name)
  end
end
