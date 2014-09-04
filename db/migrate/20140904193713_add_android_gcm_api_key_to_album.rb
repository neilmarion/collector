class AddAndroidGcmApiKeyToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :android_gcm_api_key, :string
  end
end
