FactoryBot.define do
  factory :item do
    product_name {Faker::Lorem.sentence}
    description {Faker::Lorem.sentence}
    association :user 
    category_id           {1}
    status_id             {1}
    burden_id             {1}
    delivery_id           {1}
    days_delivery_id      {1}
    price                 {5000}
  end
end
