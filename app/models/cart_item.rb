class CartItem < ApplicationRecord
  
  belongs_to :item
  belongs_to :user
  
 
  def subtotal_price
    (amount * item.price)
  end
  
end
