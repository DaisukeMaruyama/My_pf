class Item < ApplicationRecord
  
  has_many :reviews
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  attachment :image
  
  enum is_active:{販売中:true, 販売停止中:false}
  
end
