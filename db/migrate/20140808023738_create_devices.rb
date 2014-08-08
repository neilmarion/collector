class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :mac_address
      t.integer :album_id
      t.hstore :read

      t.timestamps
    end
  end
end
