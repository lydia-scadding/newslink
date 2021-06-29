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

  test "all users can visit the newest links page" do
    sign_out :user
    get newest_links_url
    assert_response :success
  end

  test "redirect if not logged in (protected route)" do
    sign_out :user
    get new_link_path
    assert_response :redirect
    follow_redirect!
    assert_select "h2", "Log in"
  end

  test "can visit the new link page" do
    get new_link_path
    assert_response :success
  end

  test "can create a link" do
    assert_difference('Link.count') do
      post links_url, params: { link: { title: "Interesting link", url: "https://medium.com/"} }
    end
    assert_redirected_to link_url(Link.last)
  end

  test "cannot create a link with invalid attributes" do
    assert_no_difference('Link.count') do
      post links_url, params: { link: { title: "", url: "" } }
    end
  end

  test "can visit the edit page if authorized" do
    get edit_link_path(@link)
    assert_response :success
  end

  test "cannot visit the edit page if not authorized" do
    sign_out :user
    sign_in users(:commenter)
    get edit_link_path(@link)
    assert_redirected_to root_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "can update link if authorized" do
    put link_url(@link), params: { link: { title: "New title", url: "http://www.link1.com"}}
    assert_redirected_to link_url(@link)
    @link.reload
    assert_equal "New title", @link.title
  end

  test "can destroy link if authorized" do
    assert_difference('Link.count', -1) do
      delete link_url(@link)
    end
    assert_redirected_to root_url
  end
end
