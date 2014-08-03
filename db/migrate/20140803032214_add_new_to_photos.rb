class AddNewToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :new, :boolean
  end
end
