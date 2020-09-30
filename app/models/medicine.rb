class Medicine < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
  scope :sorted_asc, -> { order(created_at: :asc) }
  scope :sorted_desc, -> { order(created_at: :desc) }
end
