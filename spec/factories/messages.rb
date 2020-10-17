FactoryBot.define do
  factory :message do
    sequence :content do |n|
      "message_#{n}"
    end

    conversation
    user { conversation.user }

    after(:build) do |message|
      message.conversation = create(:conversation)
      message.user = message.conversation.user
    end
  end
end