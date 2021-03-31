class OrderDetail < ApplicationRecord
  
  belongs_to :item
  belongs_to :order

  enum making_status: {出荷作業中:1, 出荷待ち:2, 出荷完了:3}

  def subtotal_price
    price * amount
  end
end
