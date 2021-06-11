require "application_system_test_case"

class LinksTest < ApplicationSystemTestCase
  setup do
    sign_in users(:admin)
    @link = links(:one)
  end

  test "can create a link" do
    visit root_url

    click_on "submit a link"
    fill_in "Title", with: "New Link"
    fill_in "Url", with: "https://newlink.com"
    click_on "Create Link"

    assert_text "New Link"
  end

  test "can update a link" do
    visit link_url(@link)

    click_on "Edit"
    fill_in "Title", with: "Updated Title"
    click_on "Update Link"

    assert_text "Updated Title"
  end

  test "can delete a project" do
    visit link_url(@link)

    accept_confirm do
      click_on "Delete"
    end

    assert_current_path(root_path)
  end
end
