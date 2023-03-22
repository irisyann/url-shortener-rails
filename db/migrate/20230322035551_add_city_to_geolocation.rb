class AddCityToGeolocation < ActiveRecord::Migration[7.0]
  def change
    add_column :geolocations, :city, :string
  end
end
