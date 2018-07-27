class Message < ApplicationRecord
  validates_presence_of :emoji


  # Make request to API
  # Parse returned message
  # Parse messages and save the parsed Venmo messages as AR objects


  class << self
    BASE_URL = "https://venmo.com/api/v5/public"
    def ordered_tally
      unordered_emoji_counts = Message.group(:emoji).count
      ordered_emoji_counts = unordered_emoji_counts.sort_by {|k, v| v}
      ordered_emoji_counts.reverse
    end

    def req(url)
      request = Faraday.get(url)
      JSON.parse(request.body)["data"]
      #outputs an array of hashes
    end

    def parse_emoji(message)
      emoji_list = EmojiData.scan(message)
      emoji_list.uniq
    end


    # Parse for unique emojis from messages.
    # Could be made more efficient by eliminating dupes before parse.


    def import_latest
      recent_trans = Message.req(BASE_URL) #array of hashes
      recent_trans.each do |tran|
        @unique_emoji = Message.parse_emoji(tran["message"])
        if @unique_emoji
          @unique_emoji.each do |emoji|
            @name = emoji.name
            Message.create(emoji: emoji)
          end
        end
      end
    end

    # Return array of daily totals for Sunday through Saturday of a type of emoji...ex: poop
    def daily_totals(emoji)
      #test....Leave for now and then at the last week.
      empty_week = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [] }

      @emoji_group = Message.where(emoji: emoji).pluck(:created_at)
      week_occurances = @emoji_group.group_by(&:wday)

      total_week_occurances = empty_week.merge(week_occurances)

      total_week_occurances


    end

  end





end
