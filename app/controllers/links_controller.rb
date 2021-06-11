class LinksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_link, only: [:edit, :update, :destroy]

  def index
    @links = Link.includes(:user, :comments)
  end

  def show; end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.new(link_params)

    if @link.save
      redirect_to link_path(@link) # Later - redirect to index if get rid of show page
    else
      render :new
    end
  end

  def edit; end

  def update
    if @link.update(link_params)
      redirect_to link_path(@link) # Later - redirect to index if get rid of show page
    else
      render :edit
    end
  end

  def destroy
    @link.destroy

    redirect_to root_path
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
