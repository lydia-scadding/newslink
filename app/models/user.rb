class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :links, dependent: :destroy
  has_many :comments
  has_many :votes

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3 }

  def voted?(link)
    votes.exists?(link: link)
  end

  def upvoted?(link)
    votes.exists?(link: link, value: 1)
  end

  def downvoted?(link)
    votes.exists?(link: link, value: -1)
  end

  def upvote(link)
    votes.create(value: 1, link: link)
  end

  def downvote(link)
    votes.create(value: -1, link: link)
  end

  private

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
