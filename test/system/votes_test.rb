require 'application_system_test_case'

class VotesTest < ApplicationSystemTestCase
  setup do
    sign_in users(:regular)
    @link = links(:one)
    visit link_url(@link)
  end

  test "upvoting a link will increment link score" do
    within '.votes' do
      find(:css, 'i.upvote').click
      assert_text('1')
    end
  end

  test "vote icon should be active after vote" do
    within '.votes' do
      find(:css, 'i.upvote').click
      assert_css('i.upvote.active')
    end
  end

  test "voting a second time should destroy first vote" do
    within '.votes' do
      find(:css, 'i.upvote').click
      find(:css, 'i.downvote').click
      assert_no_css('i.active')
      assert_text('0')
    end
  end
end
