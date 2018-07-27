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

  #test "message pull returns response" do
    #@request = external_request("https://example.com")
    #assert_not_nil @request
  #end

  #test "emoji are imported" do
    #@before = Message.count
    #Message.import_latest
    #@after = Message.count
    #assert_not_equal (@before, @after)
  #end
end
