class VotesController < ApplicationController
  before_action :find_link

  def upvote
    create_or_destroy_vote

    respond_to do |format|
      format.html { redirect_back fallback_location: links_path }
      format.js
    end
  end

  def downvote
    create_or_destroy_vote

    respond_to do |format|
      format.html { redirect_back fallback_location: links_path }
      format.js
    end
  end

  private

  def create_or_destroy_vote
    if current_user.voted?(@link)
      destroy_vote
    else
      create_vote
    end
    authorize @vote
    @link.calc_points
  end

  def destroy_vote
    @vote = current_user.votes.where(link: @link)
    @vote.destroy_all
  end

  def create_vote
    @new_vote = true
    @vote = params[:action] == "upvote" ? current_user.upvote(@link) : current_user.downvote(@link)
  end

  def find_link
    @link = Link.find(params[:id])
  end
end
