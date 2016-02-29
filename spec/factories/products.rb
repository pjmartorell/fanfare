FactoryGirl.define do
  factory :product do
    name "T-Shirt"
    price 40
    bonus_points 100000
    visible true

    factory :hidden_product do
      visible false
    end
  end
end
