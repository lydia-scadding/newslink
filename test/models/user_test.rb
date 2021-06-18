require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "has many links" do
    assert_equal 2, users(:regular).links.size
  end

  test "should destroy links when destroying self" do
    users(:regular).destroy
    assert_equal 0, Link.count
  end

  test "has many comments" do
    assert_equal 5, users(:commenter).comments.size
  end

  test "has many votes" do
    users(:commenter).votes.create(value: 1, link: links(:one))
    users(:commenter).votes.create(value: -1, link: links(:two))
    assert_equal 2, users(:commenter).votes.size
  end

  test "has a username" do
    assert_equal "Lydia", users(:regular).username
  end

  test "invalid if username is blank" do
    user = User.new(username: "")
    user.valid?
    assert_not user.errors[:username].empty?
  end

  test "invalid if the username is too short (3 characters minimum)" do
    user = User.new(username: "me")
    user.valid?
    assert_not user.errors[:username].empty?
  end

  test "invalid if username is already in use (case insensitive)" do
    user = User.new(username: "lydia")
    user.valid?
    assert_not user.errors[:username].empty?
  end
end
