require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    sign_in users(:admin)
    @link = links(:one)
  end

  test "can create a comment" do
    visit link_url(@link)

    fill_in "Enter comment", with: "New Comment"
    click_on "Create Comment"

    assert_text "New Comment"
  end
end
