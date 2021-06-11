class LinksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @links = Link.includes(:user, :comments)
  end

  def show; end

  def new; end
end
