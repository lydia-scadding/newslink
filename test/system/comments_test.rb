require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    sign_in users(:commenter)
    @link = links(:one)
    @comment = comments(:comment1)
  end

  test "can create a comment" do
    visit link_url(@link)

    fill_in "Enter comment", with: "New Comment"
    click_on "Create Comment"

    assert_text "New Comment"
  end

  test "can update a comment" do
    visit link_url(@comment.link)

    within("#comment-#{@comment.id}") do
      click_on "edit"
    end
    fill_in "Enter comment", with: "Updated text"
    click_on "Update Comment"

    assert_text "Updated text"
  end

  test "can delete a comment" do
    visit link_url(@comment.link)

    accept_confirm do
      within("#comment-#{@comment.id}") { click_on "delete" }
    end

    assert_current_path(link_path(@comment.link))
  end

  test "can view all comments" do
    visit root_url

    within(".navbar") { click_on "comments" }
    assert_selector ".comment-card", count: Comment.all.size
  end

  test "all comments on a link are displayed on show page" do
    visit link_url(@link)

    assert_selector ".comment-card", count: @link.comments.size
  end

  test "comments form rerenders with errors" do
    visit link_url(@link)

    click_on "Create Comment"
    assert_selector ".is-invalid"
    assert_selector ".invalid-feedback"
  end
end
