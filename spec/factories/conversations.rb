FactoryBot.define do
  factory :conversation do
    association :user,
    admin: true
  end
end