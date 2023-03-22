class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :geolocation
      t.references :short_url, null: false, foreign_key: true

      t.timestamps
    end
  end
end
