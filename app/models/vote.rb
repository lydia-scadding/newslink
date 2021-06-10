class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :link

  validates :value,
            presence: true,
            inclusion: { in: [-1, 1] }
end
