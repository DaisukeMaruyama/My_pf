class Order < ApplicationRecord

  validates :postal_code, presence: true
  validates :address, length: {minimum: 2, maximum: 100}, presence: true
	

  enum payment_method: {Creditcard:0, Paypal:1},  _prefix: true
  #enum shipping_method: {Includes_tracking:0, DHL_FedEx:1},  _prefix: true
  enum address_type: {"Your address":0, "Ship to registered addresses":1, "Ship to this address":2}
  enum order_status: {"Waiting for shipping":0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4},  _prefix: true

  belongs_to :user
  has_many :order_details, dependent: :destroy
  
  #後学のためコメントアウトで残す
  #def shipping_fee
  #  if shipping_method === "Includes_tracking"
  #      shipping_fee += 3.00
  #  else
  #      shipping_fee += 23.00
  #  end
  #  return shipping_fee
  #end
  
  
  def international_shipping_fee
    international_shipping_fee = 0
    case country 
      when "GB","FR","DE","IT","ES","SE" 
        international_shipping_fee += 20.00
      when "IQ","IL", "EG","TR","YE","OM","ET","NG", "JM","AR","BR","GH"
        international_shipping_fee += 17.00
      when "US","CA", "MX","AU","PE"
        international_shipping_fee += 15.00
      when "PH","RU", "TW","CN","VN", "MY", "KR"
        international_shipping_fee += 12.00  
      when "JP" 
        international_shipping_fee += 9.00    
    end
  end
  
  def delivery_time
    case country
    when "GB","FR","DE","IT","ES","SE"
      p "7-9 working days"
    when "IQ","IL", "EG","TR","YE","OM","ET","NG", "JM","AR","BR","GH"
      p "6-7 working days"
    when "US","CA", "MX","AU","PE"
      p "5-6 working days"
    when "PH","RU", "TW","CN","VN", "MY", "KR"
      p "3-4 working days"
    when "JP"
      p "1-2 working days"
    end
  end
  
    # 小計記載
  def total_price
    total = 0
    order_details.each do |order_detail|
    	total += order_detail.price * order_detail.amount
    end
    total
  end
  
  # 個数小計
	def total_count
		total = 0
		order_details.each do |order_detail|
			total += order_detail.amount
		end
		total
	end
  
end
