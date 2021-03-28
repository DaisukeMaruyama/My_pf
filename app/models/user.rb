class User < ApplicationRecord
  
  
  enum is_deleted:{Deleted: true, Nondeleted: false}

  #is_deletedされていない（false）ならログイン可能
  def active_for_authentication?
    super && (self.is_deleted == "Nondeleted")
  end
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items, dependent: :destroy
  has_many :orders
  has_many :deliveries, dependent: :destroy
  has_many :reviews
  
  
     # カートアイテム金額合計
  def cart_item_sum
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.subtotal_price
    end
    total
  end

  # カートアイテム個数合計
  def cart_total_count
    amount = 0
    cart_items.each do |cart_item|
      am += cart_item.amount
    end
    amount
  end
  
         
end
