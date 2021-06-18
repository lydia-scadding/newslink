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

  def points
    votes.sum(:value)
  end
end
