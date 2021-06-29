class LinksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :newest]
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = policy_scope(Link).includes(:user, :comments).order(points: :desc)
  end

  def show
    @comments = @link.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def newest
    @links = policy_scope(Link).order(created_at: :desc)
  end

  def new
    @link = Link.new
    authorize @link
  end

  def create
    @link = current_user.links.new(link_params)
    authorize @link

    if @link.save
      redirect_to link_path(@link), notice: "Link successfully created"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @link.update(link_params)
      redirect_to link_path(@link), notice: "Link successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @link.destroy

    redirect_to root_path, notice: "Link successfully deleted"
  end

  private

  def set_link
    @link = Link.find(params[:id])
    authorize @link
  end

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
