require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "invalid if body is blank" do
    comment = Comment.new(body: "")
    comment.valid?
    assert_not comment.errors[:body].empty?
  end
end
