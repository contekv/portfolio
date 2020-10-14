FactoryBot.define do
  factory :user do
    admin { true }
    name { Faker::Internet.username(specifier: 5..6) }
    email { Faker::Internet.email }
    password { "example-password-setting" }
    password_confirmation { "example-password-setting" }
  end

  factory :admin do
    name { name "医療従事者" }
    email { email "admin@example.jp" }
    password { "1111111" }
    password_confirmation { "1111111" }
  end
end