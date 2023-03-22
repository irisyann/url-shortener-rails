class CreateTargetUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :target_urls do |t|
      t.string :target_url, null: false
      t.string :title_tag, null: false, default: "Untitled"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
