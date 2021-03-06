class Item < ApplicationRecord
  
  validates :image, presence: true
  validates :item_name, length: {minimum: 1, maximum:60}, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :price, numericality: true, presence: true
  
  has_many :reviews
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  attachment :image
  
  enum is_active:{販売中:true, 販売停止中:false}
  
  def self.sort(selection)
    case selection
      when 'new'
        return all.order(created_at: :DESC)
      when 'high'
        return all.order(price: :DESC)
      when 'low'
        return all.order(price: :ASC)
    end  
  end
  
end
