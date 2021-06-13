class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit]

  def create
    @link = Link.find_by(id: params[:link_id])
    @comment = @link.comments.new(user: current_user, body: comment_params[:body])
    authorize @comment

    if @comment.save
      redirect_to @link, notice: "Comment successfully created"
    else
      redirect_to @link, notice: "Comment not saved. Ensure you have entered a comment."
    end
  end

  def edit; end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
