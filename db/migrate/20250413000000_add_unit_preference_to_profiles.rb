class AddUnitPreferenceToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :unit_preference, :string, default: 'metric'
  end
end
