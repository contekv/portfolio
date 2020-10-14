FactoryBot.define do
  factory :message do
    sequence :content do |n|
      "message_#{n}"
    end

    after(:build) do |message|
      message.conversation = create(:conversation)
      message.user = message.conversation
    end
  end
end