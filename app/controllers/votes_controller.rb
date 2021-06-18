class VotesController < ApplicationController
  before_action :find_link

  def create
    create_or_destroy_vote_for(@link)
    @is_upvote = params[:value] == '1'

    respond_to do |format|
      format.html { redirect_back fallback_location: links_path }
      format.js
    end
  end

  private

  def create_or_destroy_vote_for(link)
    if current_user.voted?(link)
      @vote = current_user.votes.where(link: link)
      @vote.destroy_all
    else
      @vote = @link.votes.create(value: params[:value], user: current_user)
      @new_vote = true
    end
    authorize @vote
  end

  def find_link
    @link = Link.find(params[:link_id])
  end
end
