require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:commenter)
    @link = links(:one)
    @comment = comments(:comment1)
  end

  test "all users can visit the comments page" do
    sign_out :user
    get comments_url
    assert_response :success
  end

  test "can create a comment if logged in" do
    assert_difference('Comment.count') do
      post link_comments_url(@link), params: { comment: { body: "Thanks for posting this link!"}, link_id: @link.id }
    end
    assert_redirected_to link_url(@link)
  end

  test "cannot create a comment if not logged in" do
    sign_out :user
    assert_no_difference('Comment.count') do
      post link_comments_url(@link), params: { comment: { body: "Thanks for posting this link!"}, link_id: @link.id }
    end

    assert_redirected_to new_user_session_url
  end

  test "cannot create a comment with invalid attributes" do
    assert_no_difference('Comment.count') do
      post link_comments_url(@link), params: { comment: { body: ""}, link_id: @link.id }
    end
  end

  test "can visit the edit page if authorized" do
    get edit_comment_path(@comment)
    assert_response :success
  end

  test "can update comment if authorized" do
    put comment_url(@comment), params: { comment: { body:"Different text" }}
    assert_redirected_to link_url(@comment.link, anchor: "comment-#{@comment.id}")
    @comment.reload
    assert_equal "Different text", @comment.body
  end

  test "can destroy comment if authorized" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end
    assert_redirected_to link_url(@comment.link)
  end
end
