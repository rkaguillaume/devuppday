class AddPriceassoToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :priceasso, :integer
  end
end
