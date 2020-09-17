class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.text :content
      t.integer :order_type, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end