class AddQuestionToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :question, :text
  end
end
