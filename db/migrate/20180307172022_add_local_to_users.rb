class AddLocalToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :local, :boolean
  end
end
