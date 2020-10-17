FactoryBot.define do
  factory :order do
    content { content }
    association :user
  end
end
