require 'test_helper'
require 'pry-byebug'

class VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:regular)
    @link = links(:one)
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

  # test "link points updates with new vote" do
  #   @link.calc_points
  #   assert_difference('@link.points') do
  #     post link_votes_url(@link, value: 1)
  #     p @link.votes
  #     p @link.points
  #     binding.pry
  #   end
  # end

end
