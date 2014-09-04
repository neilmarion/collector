class AddNotifMessgeToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :message, :string
  end
end
