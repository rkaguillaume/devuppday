class AddAssociatToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :associat, :boolean
  end
end
