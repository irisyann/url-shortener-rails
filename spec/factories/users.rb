FactoryBot.define do
  factory :user do
    email { 'hi@gmail.com' }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
