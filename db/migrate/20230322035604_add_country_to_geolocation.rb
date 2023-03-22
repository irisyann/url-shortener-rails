class AddCountryToGeolocation < ActiveRecord::Migration[7.0]
  def change
    add_column :geolocations, :country, :string
  end
end
