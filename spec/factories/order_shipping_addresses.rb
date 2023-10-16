FactoryBot.define do
  factory :order_shipping_address do
    portal_code          { '123-4567' }
    prefecture_id        { rand(2..48) }
    city                 { '福岡市' }
    address              { '1-1' }
    building             { '福岡ハイツ' }
    phone                { Faker::Number.number(digits: 10) }
    token                { 'tok_abcdefghijk00000000000000000' }
  end
end