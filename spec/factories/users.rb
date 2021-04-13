FactoryBot.define do
  factory :user do
    first_name { Faker::Lorem.characters(number: 10) }
    last_name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
