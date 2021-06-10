require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "has a username" do
    assert_equal "Lydia", users(:regular).username
  end

  test "username cannot be blank" do
    user = User.new
    user.valid?
    assert_not user.errors[:username].empty?
  end

  test "has many links" do
    assert_equal 2, users(:regular).links.size
  end
end
