class VotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def upvote?
    true
  end

  def downvote?
    upvote?
  end
end
