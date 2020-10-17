FactoryBot.define do
  factory :medicine do
    content { content }
    association :user
  end
end