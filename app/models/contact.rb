class Contact < ApplicationRecord
  validates :email, presence: true, length: {maximum:255},format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :message, presence: true
  validates :subject, presence: true
  
  enum subject: {"---"=>0, "Delivery"=> 1, "Order Issues"=> 2 , "Product & Stock"=> 3 , "Others"=> 4 }
  
end
