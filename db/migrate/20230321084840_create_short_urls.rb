class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.integer :num_clicks, null: false, default: 0
      t.string :short_path, null: false, unique: true
      t.references :target_url, null: false, foreign_key: true

      t.timestamps
    end
  end
end
