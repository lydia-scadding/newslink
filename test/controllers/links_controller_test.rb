require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:regular)
    @link = links(:one)
  end

  test "all users can visit the index page" do
    sign_out :user
    get root_url
    assert_response :success
  end

  test "all users can view the details of a link" do
    sign_out :user
    get link_url(@link)
    assert_response :success
  end

  test "redirect if not logged in (protected route)" do
    sign_out :user
    get new_link_path
    assert_response :redirect
    follow_redirect!
    assert_select "h2", "Log in"
  end
  # other CRUD actions
  # LATER: all users can visit the newest links page
  # LATER: all users can visit the all comments page


end
