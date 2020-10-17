FactoryBot.define do
  factory :user do
    name { Faker::Internet.username(specifier: 5..6) }
    email { Faker::Internet.email }
    password { "example-password-setting" }
    password_confirmation { "example-password-setting" }
  end
end