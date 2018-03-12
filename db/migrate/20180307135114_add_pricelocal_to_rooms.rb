class AddPricelocalToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :pricelocal, :integer
  end
end
