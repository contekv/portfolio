class Order < ApplicationRecord
  belongs_to :user
  enum order_type: { waiting: 0, running: 1, arrival: 2, completed: 3 }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  scope :sorted_desc, -> { order(created_at: :desc) }
  paginates_per 5
end