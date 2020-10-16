require 'rails_helper'

describe Conversation do
  # coversaiton_modelは有効な状態であること
  it "is valid with a conversation model" do
    conversation = build(:conversation)
    expect(conversation).to be_invalid
  end
end
