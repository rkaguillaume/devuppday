class AddParticulierToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :particulier, :boolean
  end
end
