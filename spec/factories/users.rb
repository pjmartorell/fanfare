include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "name#{n}" }
    sequence(:email) { |n| "email#{n}@fanfare.com" }
    password "password"
  end
end
