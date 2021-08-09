FactoryBot.define do
  factory :purchase_shipping do
    token              {"tok_abcdefghijk00000000000000000"}
    postal_code        { '000-0000' }
    prefecture_id      { Faker::Number.rand(2..48) }
    address            { '住所001' }
    address_number     { '住所002' }
    building_name      { 'ビルディング1' }
    phone_number       { 11111111111 }
    # association :user
    # association :item
  end
end
