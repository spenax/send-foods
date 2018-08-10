class MessagesController < ApplicationController
  helper_method :messages_helper


  def index
    @hourly_list = Message.hourly_tally[0..9]
    @trends = Message.last_three(@hourly_list)

  end

  def compare

    @emoji_one = params[:emoji][0]
    @emoji_two = params[:emoji][1]

    first_totals = Message.daily_totals(@emoji_one)
    second_totals = Message.daily_totals(@emoji_two)


    @first_emo_zero = first_totals[0]
    @first_emo_one = first_totals[1]
    @first_emo_two = first_totals[2]

    @second_emo_zero = second_totals[0]
    @second_emo_one = second_totals[1]
    @second_emo_two = second_totals[2]


  end

  def show

    @emoji = params[:emoji]
    @message = Message.find_by(emoji: @emoji)
    totals = Message.daily_totals(@emoji)
    @trend = Message.single_trend(@emoji)


    @day_zero = totals[0]
    @day_one = totals[1]
    @day_two = totals[2]


    #@name = find_name(@emoji)



  end

  private
      def message_params
        params.require(:message).permit(:emoji)
      end
end
