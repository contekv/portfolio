require 'rails_helper'

describe Order do
  # 141文字以上であれば無効な状態であること
  it "is invalid order model with a 141 characters or more" do
    content = Faker::Lorem.characters(141)
    order = build(:order, content: content)
    order.valid?
    expect(order.errors[:content]).to include("は140文字以内で入力してください")
  end

  # 内容が無ければ無効な状態であること
  it "is invalid without a order content" do
    user = build(:order, content: nil)
    user.valid?
    expect(user.errors[:content]).to include("を入力してください")
  end
end