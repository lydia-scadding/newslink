require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:commenter)
    @link = links(:one)
    @comment = comments(:comment1)
  end

  test "can create a comment if logged in" do
    assert_difference('Comment.count') do
      post link_comments_url(@link), params: { comment: { body: "Thanks for posting this link!"}, link_id: @link.id }
    end
    assert_redirected_to link_url(@link)
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
    assert_redirected_to link_url(@comment.link)
    @comment.reload
    assert_equal "Different text", @comment.body
  end

  # test "can destroy link if authorized" do
  #   assert_difference('Link.count', -1) do
  #     delete link_url(@link)
  #   end
  #   assert_redirected_to root_url
  # end
end
