class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @link = Link.find_by(id: params[:link_id])
    @comment = @link.comments.new(user: current_user, body: comment_params[:body])
    authorize @comment

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @link, notice: "Comment successfully created" }
        format.js
      else
        format.html { redirect_to @link, notice: "Comment not saved. Ensure you have entered a comment." }
      end
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to link_path(@comment.link), notice: "Comment successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy

    redirect_to link_path(@comment.link), notice: "Comment successfully deleted"
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
