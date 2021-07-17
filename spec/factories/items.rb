FactoryBot.define do
  factory :item do
    name               { Faker::Lorem.word }
    description        { Faker::Lorem.sentence }
    category_id        { Faker::Number.rand(2..11) }
    status_id          { Faker::Number.rand(2..7) }
    burden_id          { Faker::Number.rand(2..3) }
    prefecture_id      { Faker::Number.rand(2..48) }
    day_to_ship_id     { Faker::Number.rand(2..4) }
    price              { Faker::Number.rand(300..9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
