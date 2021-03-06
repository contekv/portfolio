class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates :user_id, presence: true
  validates :conversation_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  scope :sorted_desc, -> { order(created_at: :desc) }
end