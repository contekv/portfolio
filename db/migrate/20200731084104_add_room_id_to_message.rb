class AddRoomIdToMessage < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :room, foreign_key: true
  end
end
