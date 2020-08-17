class User < ApplicationRecord
  has_many :conversations, dependent: :destroy
  has_many :messages, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end