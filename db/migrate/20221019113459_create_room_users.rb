class CreateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_users do |t|
      t.references :user,  foreign_key: true, null: false
      t.references :room,  foreign_key: true, null: false

      t.timestamps
    end
  end
end
