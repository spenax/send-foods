require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "valid message saves" do
    @message = Message.new(emoji: "dog")
    assert @message.save
  end

  test "emoji is not nil" do
    @message = Message.new
    assert_not @message.save
  end

  test "emoji is not blank" do
    @message = Message.new(emoji: " ")
    assert_not @message.save
  end
end
