class Conversation < ApplicationRecord
  has_many :messages
  belongs_to :user
  validates :user_id, presence: true
  validates :admin_id, presence: true
  scope :sorted_desc, -> { order(created_at: :desc) }
  scope :admin, -> { find_by(name: "管理者") }
  paginates_per 5
end