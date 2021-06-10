require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test "has a title" do
    assert_equal "link1", links(:one).title
  end

  test "invalid if title is blank" do
    link = Link.new(title: "")
    link.valid?
    assert_not link.errors[:title].empty?
  end

  test "invalid if title is already in use (case insensitive)" do
    link = Link.new(title: "LINK1")
    link.valid?
    assert_not link.errors[:title].empty?
  end

  test "invalid if url is not in the right format" do
    url = "NOT A REAL URL"
    link = Link.new(title: "some article", url: url)
    link.valid?
    assert_not link.errors[:url].empty?
  end
end
