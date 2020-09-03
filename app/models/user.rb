class User < ApplicationRecord
  has_one_attached :avatar
  has_many :conversations, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :medicines,  dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :admin, -> { find_by(name: "管理者") }
  scope :not_admin, -> { where.not(name: "管理者") }
  scope :sorted_desc, -> { order(created_at: :desc) }
end