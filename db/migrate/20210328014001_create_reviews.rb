class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.float :rate
      t.text :comment
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
