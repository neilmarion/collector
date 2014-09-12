class AddShowPhotosDefaultToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :show_photos_default, :boolean, default: true
  end
end
