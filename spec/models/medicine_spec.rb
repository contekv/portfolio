require 'rails_helper'

describe Medicine do
  # medicine_modelが有効な状態であること
  it "is valid with a medicine model" do
    medicine = build(:medicine, content: "medicine note")
    medicine.valid?
  end

  # 内容が51文字以上であれば無効な状態であること
  it "is valid with a medicine 50 characters or less" do
    content = Faker::Lorem.characters(51)
    user = build(:medicine, content: content)
    user.valid?
    expect(user.errors[:content]).to include("は50文字以内で入力してください")
  end

  # 内容が無ければmedicine contentは無効な状態であること
  it "is invalid without a medicine content" do
    user = build(:medicine, content: nil)
    user.valid?
    expect(user.errors[:content]).to include("を入力してください")
  end
end
