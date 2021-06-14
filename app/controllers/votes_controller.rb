class VotesController < ApplicationController
  before_action :find_link

  def upvote
    @vote = @link.votes.create(value: 1, user: current_user)
    authorize @vote

    redirect_back fallback_location: links_path
  end

  def downvote
    @vote = @link.votes.create(value: -1, user: current_user)
    authorize @vote

    redirect_back fallback_location: links_path
  end

  private

  def find_link
    @link = Link.find(params[:id])
  end
end
