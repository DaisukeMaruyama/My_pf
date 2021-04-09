class ChangeColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :payment_method, :integer
    add_column :orders, :delivery_time, :string
  end
end
