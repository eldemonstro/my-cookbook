FactoryBot.define do
  factory :user do
    name 'Ronaldo'
    sequence(:email) { |n| "user_#{n}@example.com" }
    password '123456789'
    city 'Campinas - SP'
  end
end
