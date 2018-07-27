class MessagesController < ApplicationController
  helper_method :messages_helper
  def index
    @emoji_list = Message.ordered_tally[0..9]

  end

  def show
    @emoji = params[:emoji]
    @message = Message.find_by(emoji: @emoji)
    totals = Message.daily_totals(@emoji)

    @sun = totals[0].size
    @mon = totals[1].size
    @tues = totals[2].size
    @wed = totals[3].size
    @thur = totals[4].size
    @fri = totals[5].size
    @sat = totals[6].size




  end

  private
      def message_params
        params.require(:message).permit(:emoji)
      end
end
