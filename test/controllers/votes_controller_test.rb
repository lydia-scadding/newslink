require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in users(:regular)
    @link = links(:one)
  end

  test "can upvote a link" do
    assert_difference('Vote.count') do
      post upvote_link_url(@link)
    end
    assert_response :redirect
    assert_equal 1, Vote.last.value
  end

  test "can downvote a link" do
    assert_difference('Vote.count') do
      post downvote_link_url(@link)
    end
    assert_response :redirect
    assert_equal -1, Vote.last.value
  end
end
