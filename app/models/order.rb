class Order < ApplicationRecord

  validates :postal_code, presence: true
  validates :address, length: {minimum: 2, maximum: 100}, presence: true
	validates :name, length: {minimum: 1}, presence: true

  enum payment_method: {Creditcard:0, Paypal:1}
  enum shipping_method: {"Includes tracking (SP)":0, "DHL / FedEx":1}
  enum address_type: {"Your address":0, "Ship to registered addresses":1, "Ship to this address":2}
  enum order_status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}

  belongs_to :user
  has_many :order_details, dependent: :destroy


end
