FactoryBot.define do
  factory :purchase_residence do
    postal_code       { '123-4567' }
    municipality      { '青山市' }
    delivery_id       {2}
    address           { '1-1' }
    building_name     { '人間ハイツ' }
    phone_number      { '0000000000' }
    token             {"tok_abcdefghijk00000000000000000"}
  end
end
