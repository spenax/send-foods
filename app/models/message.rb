class Message < ApplicationRecord
  validates_presence_of :emoji
  scope :last_hour, -> { where('created_at > ?', 1.hour.ago)}
  scope :last_hour_plus_one, -> { where('created_at < ? AND created_at > ?', 1.hour.ago, 2.hours.ago)}
  scope :last_hour_plus_two, -> { where('created_at < ? AND created_at > ?', 2.hours.ago, 3.hours.ago)}

  scope :last_three_hours_combined, -> { where('created_at > ?', 3.hours.ago)}
  # Probably bad becauce they will return all if nil?
  # This might not be great because these are periods of 24 hours instead of calendar days...Might be cool as a line graph
  # At that point you could create a comparison action

  # 1 day ago
  scope :last_day, -> { where('created_at < ? AND created_at > ?', Time.now, 1.days.ago)}
  # 2 days ago
  scope :last_day_plus_one, -> { where('created_at < ? AND created_at > ?', 1.day.ago, 2.days.ago)}
  # 3 days ago
  scope :last_day_plus_two, -> { where('created_at < ? AND created_at > ?', 2.day.ago, 3.days.ago)}
  # 4 days ago
  scope :last_day_plus_three, -> { where('created_at < ? AND created_at > ?', 3.day.ago, 4.days.ago)}
  # 5 days ago
  scope :last_day_plus_four, -> { where('created_at < ? AND created_at > ?', 4.day.ago, 5.days.ago)}
  # 6 days ago
  scope :last_day_plus_five, -> { where('created_at < ? AND created_at > ?', 5.day.ago, 6.days.ago)}
  # 7 days ago
  scope :last_day_plus_six, -> { where('created_at < ? AND created_at > ?', 6.day.ago, 7.days.ago)}



  # Make request to API
  # Parse returned message
  # Parse messages and save the parsed Venmo messages as AR objects


  class << self
    BASE_URL = "https://venmo.com/api/v5/public"
    def alltime_tally
      @all_time_counts = self.group(:emoji).count
      self.reverse_sort(@all_time_counts)

    end

    def hourly_tally
      @hourly_counts = self.last_hour.group(:emoji).count
      self.reverse_sort(@hourly_counts)

    end

    def reverse_sort (group)
      @ordered_emoji_counts = group.sort_by {|k, v| v}
      @ordered_emoji_counts.reverse

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
      recent_trans = self.req(BASE_URL) #array of hashes
      recent_trans.each do |tran|
        @unique_emoji = self.parse_emoji(tran["message"])
        if @unique_emoji
          @unique_emoji.each do |emoji|
            @name = emoji.name
            self.create(emoji: emoji)
          end
        end
      end
    end

    # Return array of daily totals for Sunday through Saturday of a type of emoji...ex: poop
    def daily_totals(emoji)

      @day_zero = self.last_day.where(emoji: emoji).pluck(:created_at).size
      @day_one = self.last_day_plus_one.where(emoji: emoji).pluck(:created_at).size
      @day_two = self.last_day_plus_two.where(emoji: emoji).pluck(:created_at).size
      some_days = [@day_zero, @day_one, @day_two]

    end


    #return 1 if the average rate of change of set of points is increasing at an increasing rate

    def rate_of_change(p_two, p_one, p_zero)

      #this is the most recent slope
      @l_zero = p_zero - p_one

      #this is the older slope
      @l_one = p_one - p_two

      if (@l_zero.abs > @l_one.abs) && (@l_zero > 0)
        1
      #elsif @l_zero.abs < @l_one.abs
        #-1
      else
        0
      end
    end

    def last_three (emoji_list)
      past_three = self.last_three_hours_combined
      trends = []
      emoji_list.each do |emoji_pair|
        emoji = emoji_pair[0]
        @first_hour_ago = past_three.last_hour.where(emoji: emoji).pluck(:created_at).length
        @second_hour_ago = past_three.last_hour_plus_one.where(emoji: emoji).pluck(:created_at).length
        @third_hour_ago = past_three.last_hour_plus_two.where(emoji: emoji).pluck(:created_at).length
        rate = rate_of_change(@third_hour_ago, @second_hour_ago, @first_hour_ago)
        trends.push(rate)
      end
      trends

    end









  end





end
