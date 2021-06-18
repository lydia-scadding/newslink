require 'test_helper'
require 'pry-byebug'

class VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:regular)
    @link = links(:one)
  end

  test "cannot vote unless signed in" do
    sign_out :user

    post link_votes_url(@link, value: 1)
    assert_redirected_to new_user_session_url
  end

  test "can upvote a link" do
    assert_difference('Vote.count') do
      post link_votes_url(@link, value: 1)
    end
    assert_response :redirect
    assert_equal 1, Vote.last.value
  end

  test "can downvote a link" do
    assert_difference('Vote.count') do
      post link_votes_url(@link, value: -1)
    end
    assert_response :redirect
    assert_equal -1, Vote.last.value
  end

  test "trying to vote a second time will destroy first vote" do
    assert_difference('Vote.count') do
      post link_votes_url(@link, value: 1)
    end
    assert_difference('Vote.count', -1) do
      post link_votes_url(@link, value: 1)
    end
  end

  # test "link points updates with new vote" do
  #   p @link.points
  #   assert_difference('@link.points') do
  #     post link_votes_url(@link, value: 1)
  #   end
  #   p @link.points
  # end

end
