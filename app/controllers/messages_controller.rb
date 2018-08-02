class MessagesController < ApplicationController
  helper_method :messages_helper


  def index
    @hourly_list = Message.hourly_tally[0..9]
    @trends = Message.last_three(@hourly_list)



  end

  def show
    @emoji = params[:emoji]
    @message = Message.find_by(emoji: @emoji)
    totals = Message.daily_totals(@emoji)
    egg_totals = Message.daily_totals("🍆")


    @day_zero = totals[0]
    @day_one = totals[1]
    @day_two = totals[2]

    @egg_day_zero = egg_totals[0]
    @egg_day_one = egg_totals[1]
    @egg_day_two = egg_totals[2]


  end

  private
      def message_params
        params.require(:message).permit(:emoji)
      end
end
