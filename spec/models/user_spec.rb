require 'rails_helper'

describe User do
  # 名前、メール、パスワード、確認用パスワードがあれば有効な状態であること
  describe '#create' do
    it "is valid with a name, email, password and password confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  # 名前がなければ無効な状態であること
  it "is invalid without a user name" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  # 重複したメールアドレスなら無効な状態であること
  describe '#create' do
    it "is invalid with a duplicate email address" do
      create(:user, email: "tester@example.com")
      user = build(:user, email: "tester@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end

  # ユーザーの名前を文字列として返すこと
  it "returns a user's full name as a string" do
    user = build(:user, name: "加藤1")
    expect(user.name).to eq "加藤1"
  end

  # パスワードが無ければ無効な状態であること
  it "is invalid without an password" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  # パスワードが６文字以上であれば登録できる
  it "is valid with a password 6 characters or more" do
    password = Faker::Internet.password(min_length: 6, max_length: 6)
    user = build(:user, password: password, password_confirmation: password)
    expect(user).to be_valid
  end

  # パスワードが5文字以下であれば無効な状態であること
  it "is invalid with a password 5 characters or less" do
    password = Faker::Internet.password(min_length: 5, max_length: 5)
    user = build(:user, password: password, password_confirmation: password)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end

  # パスワードと確認用が一致していないと無効な状態であること
  it "is invalid with a password and confirmation do not match" do
    user = build(:user, password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end
end