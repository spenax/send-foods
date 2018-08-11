
  desc "Rake task for import latest transactions"
  task :new_venmo_trans => [ :environment ] do
    puts "Grabbing latest transactions..."
    @latest = Message.get_simple_parse
    Message.import_latest(@latest)
    puts "Latest transactions processed and imported at #{Time.now}"
  end
