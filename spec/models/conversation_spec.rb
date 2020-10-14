require 'rails_helper'

describe Conversation do
  # coversaiton_modelが作成される
  it "is valid with a conversation model" do
    conver = build(:conversation)
    expect(conver).to be_invalid
  end
end
