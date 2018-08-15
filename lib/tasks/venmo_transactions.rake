
  desc "Rake task for import latest transactions"
  task :new_venmo_trans => [ :environment ] do
    puts "Grabbing latest transactions..."
    #@latest = Message.get_simple_parse
    @latest = Payment.get_simple_parse

    @latest.nil? ? "request failed" : "request successful"

    @latest.each do |tran|
      @payment = Payment.create(note: tran["message"],
        actor_name: tran["actor"]["firstname"],
        target_name: tran["transactions"].first["target"]["firstname"])
      @unique_emoji = Message.parse_emoji(tran["message"])
      if @unique_emoji.any?
        @unique_emoji.each do |emoji|
          @message = @payment.messages.build(emoji: emoji)
          @message.save
        end

      end
    end

    #Message.import_latest(@latest)

    puts "Latest transactions processed and imported at #{Time.now}"
  end
