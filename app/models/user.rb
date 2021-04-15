class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :last_name, presence: true, length: {minimum: 2, maximum: 20}
  validates :first_name, presence: true, length: {minimum: 2, maximum: 20}
  
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
  
  def cart_total_with_shipping
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.subtotal_price 
      total += cart_item.international_shipping_fee.to_d  #ここにデータが渡ってない。@cart_item.countryが来なければいけない
    end
    total
  end 
  
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
      amount += cart_item.amount.to_i
    end
    amount
  end
  
  def country_name
    c = ISO3166::Country[self.country]
    return c.translations[I18n.locale.to_s] || c.name
  end
  
         
end
