FactoryBot.define do
  factory :log do
    host "example.com"
    path "/test"
    http_method "GET"
    status { 200 }
    fwd { Faker::Internet.public_ip_v4_address }
    created_at { Time.current }
    request_id { Faker::Internet.ip_v6_address }
  end
end
