class AddShowToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :show, :boolean, default: true
  end
end
