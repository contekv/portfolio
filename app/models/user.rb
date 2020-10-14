class User < ApplicationRecord
  has_one_attached :avatar
  has_many :conversations, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :medicines,  dependent: :destroy
  has_many :orders, dependent: :destroy
  validates :name, :email, presence: true
  validates :name, :email, uniqueness: { case_sensitive: false }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :admin, -> { find_by(name: "医療従事者") }
  scope :not_admin, -> { where.not(name: "医療従事者") }
  scope :sorted_desc, -> { order(created_at: :desc) }

  def self.secure_guest(email)
    find_or_create_by!(email: email) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end