class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :room_type
      t.integer :volume
      t.integer :surface
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_table
      t.boolean :is_chair
      t.boolean :is_kitchen
      t.boolean :is_wc
      t.boolean :is_parking
      t.boolean :is_outdoor
      t.boolean :is_tv
      t.boolean :is_projector
      t.boolean :is_stage
      t.boolean :is_shower
      t.boolean :is_sound
      t.boolean :is_bar
      t.boolean :is_air
      t.boolean :is_heating
      t.boolean :is_wifi
      t.boolean :is_decoration
      t.boolean :is_wedding
      t.boolean :is_baptism
      t.boolean :is_birthday
      t.boolean :is_special
      t.boolean :is_meeting
      t.boolean :is_lotto
      t.boolean :is_gathering
      t.boolean :is_concert
      t.boolean :is_show
      t.boolean :is_seminary
      t.boolean :is_conference
      t.integer :price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
