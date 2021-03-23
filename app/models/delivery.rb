class Delivery < ApplicationRecord
  
  belongs_to :user
  
  def full_shipping_address
    self.first_name + "　" + self.last_name + "　" + self.delivery_address + "　" +  self.delivery_city + "　" + self.delivery_postal_code + "　" + self.delivery_country
  end
  
end
