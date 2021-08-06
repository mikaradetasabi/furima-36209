FactoryBot.define do
  factory :item do
    product_name {Faker::Lorem.sentence}
    image {Faker::Lorem.sentence}
    description {Faker::Lorem.sentence}
    association :user 
    category_id           {2}
    status_id             {2}
    burden_id             {2}
    delivery_id           {2}
    days_delivery_id      {2}
    price                 {5000}
  end
end
