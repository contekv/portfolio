require 'rails_helper'

describe Message do
  # message modelが作成される
  it "is valid with a message model" do
    message = build(:message, content:'test message')
    expect(message).to be_valid
  end
end