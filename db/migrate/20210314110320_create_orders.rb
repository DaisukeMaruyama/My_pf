class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string "postal_code"
      t.string "address"
      t.decimal "shipping_cost", precision: 8, scale: 2
      t.decimal "total_payment", precision: 8, scale: 2
      t.string "last_name"
      t.string "first_name"
      t.string "country"
      t.string "city"
      t.integer "shipping_method", default: 0
      t.integer "payment_method", default: 0
      t.integer "order_status", default: 0

      t.timestamps
    end
  end
end
