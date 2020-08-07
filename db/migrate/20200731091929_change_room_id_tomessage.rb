class ChangeRoomIdTomessage < ActiveRecord::Migration[6.0]
  def change
    change_column_null :messages, :room_id, null: false
  end
end
