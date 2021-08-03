FactoryBot.define do
  factory :user do
    nickname              {"furima"}
    email                 {"furima@com"}
    password              {"furima11"}
    encrypted_password    {"furima11"}
    last_name           {"不利魔"}
    last_name_kana      {"フリマ"}
    first_name            {"太郎"}
    first_name_kana       {"タロウ"}
    birthday             {"1999-02-01"}
  end
end