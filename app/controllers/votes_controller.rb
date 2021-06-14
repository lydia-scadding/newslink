class VotesController < ApplicationController
  before_action :find_link

  def create
    if current_user.voted?(@link)
      @vote = current_user.votes.where(link: @link)
      @vote.destroy_all
    else
      @vote = @link.votes.create(value: params[:value], user: current_user)
    end
    authorize @vote
    @link.calc_points

    redirect_back fallback_location: links_path
  end

  private

  def find_link
    @link = Link.find(params[:link_id])
  end
end
