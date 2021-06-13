require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:regular)
    @link = links(:one)
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
end
