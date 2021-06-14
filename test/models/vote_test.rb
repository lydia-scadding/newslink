require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "has a value" do
    assert_equal 1, votes(:upvote).value
  end

  test "invalid if value is blank" do
    vote = Vote.new
    vote.valid?
    assert_not vote.errors[:value].empty?
  end

  test "valid with a value of 1 or -1" do
    [1, -1].each do |val|
      vote = Vote.new(value: val)
      vote.valid?
      assert_empty vote.errors[:value]
    end
  end

  test "invalid with a value other than 1 or -1" do
    vote = Vote.new(value: 3)
    vote.valid?
    assert_not vote.errors[:value].empty?
  end

  test "a user only has 1 vote per link" do
    vote_one = Vote.create(user: users(:regular), link: links(:one), value: 1)
    vote_two = Vote.new(user: users(:regular), link: links(:one), value: 1)
    vote_two.valid?
    assert_not vote_two.errors[:user].empty?
  end
end
