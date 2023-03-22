class ChangeTargetUrlUserRef < ActiveRecord::Migration[7.0]
  def change
    change_column(:target_urls, :user_id, :integer, null: true)
  end
end
