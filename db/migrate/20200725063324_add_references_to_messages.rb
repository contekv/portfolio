class AddReferencesToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :user, foreign_key: true
  end
  add_index :messages, [:user_id, :created_at]
end
