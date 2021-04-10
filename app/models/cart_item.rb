class CartItem < ApplicationRecord
  
  belongs_to :item
  belongs_to :user
  
 
  def subtotal_price
    (amount * item.price)
  end
  
  def international_shipping_fee
    international_shipping_fee = 0
    case country 
      when "GB","FR","DE","IT","ES","SE" 
        international_shipping_fee += 15.00
      when "IQ","IL", "EG","TR","YE","OM","ET","NG", "JM","AR","BR","GH"
        international_shipping_fee += 12.00
      when "US","CA", "MX","AU","PE"
        international_shipping_fee += 9.00
      when "PH","RU", "TW","CN","VN", "MY", "KR"
        international_shipping_fee += 7.00  
      when "JP" 
        international_shipping_fee += 4.00    
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
  
  def country_name
   c = ISO3166::Country[self.country]
   return c.translations[I18n.locale.to_s] || c.name
  end


end
