class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.references :user, foreign_key: true
      t.string "last_name"
      t.string "first_name"
      t.string "delivery_postal_code"
      t.string "delivery_ddress"
      t.string "delivery_country"
      t.string "delivery_city"

      t.timestamps
    end
  end
end
