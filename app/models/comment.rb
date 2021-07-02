class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :link

  validates :body, presence: true

  scope :by_date, -> { order(created_at: :desc) }
end
