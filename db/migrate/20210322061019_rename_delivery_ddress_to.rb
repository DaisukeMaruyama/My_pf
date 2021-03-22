class RenameDeliveryDdressTo < ActiveRecord::Migration[5.2]
  def change
    rename_column :deliveries, :delivery_ddress, :delivery_address
  end
end
