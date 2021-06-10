class Link < ApplicationRecord
  belongs_to :user

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :url, format: { with: %r{\Ahttps?://} }
end
