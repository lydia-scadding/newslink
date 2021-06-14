class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :link

  validates :value,
            presence: true,
            inclusion: { in: [-1, 1] }

  validates :user, uniqueness: { scope: :link }
end
