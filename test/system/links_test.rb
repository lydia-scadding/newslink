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

    within(".link-card") do
      click_on "edit"
    end
    fill_in "Title", with: "Updated Title"
    click_on "Update Link"

    assert_text "Updated Title"
  end

  test "can delete a link" do
    visit link_url(@link)

    accept_confirm do
      within(".link-card") { click_on "delete" }
    end

    assert_current_path(root_path)
  end

  test "can visit the newest links page" do
    visit root_url
    within(".navbar") { click_on "newest" }

    assert_current_path(newest_links_path)
  end
end
