class AddRegIdAndPlatformAndPushNotifEnabledToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :reg_id, :string
    add_column :devices, :platform, :string
    add_column :devices, :push_notif_enabled, :boolean
  end
end
