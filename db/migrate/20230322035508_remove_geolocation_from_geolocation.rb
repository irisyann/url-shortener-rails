class RemoveGeolocationFromGeolocation < ActiveRecord::Migration[7.0]
  def change
    remove_column :geolocations, :geolocation, :string
  end
end
