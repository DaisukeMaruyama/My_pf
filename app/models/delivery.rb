class Delivery < ApplicationRecord

  validates :delivery_postal_code, presence: true
  validates :delivery_address, length: {minimum: 2, maximum: 100}, presence: true
  validates :delivery_city, presence: true
  validates :delivery_country, presence: true
	validates :last_name, length: {minimum: 1}, presence: true
	validates :first_name, length: {minimum: 1}, presence: true

  belongs_to :user

  def full_shipping_address
    self.first_name + "　" + self.last_name + "　" + self.delivery_address + "　" +  self.delivery_city + "　" + self.delivery_postal_code + "　" + self.country_name
  end

  def country_name
    c = ISO3166::Country[self.delivery_country]
    return c.translations[I18n.locale.to_s] || c.name
  end

end
