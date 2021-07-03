class Link < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :url,
            presence: true,
            format: { with: %r{\Ahttps?://} }

  scope :by_date, -> { order(created_at: :desc) }
  scope :by_points, -> { order(points: :desc) }

  def calc_points
    update_attribute(:points, votes.sum(:value))
  end
end
