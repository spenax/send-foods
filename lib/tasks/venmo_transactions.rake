
  desc "Rake task for import latest transactions"
  task :new_venmo_trans => [ :environment ] do
    puts "Grabbing latest transactions..."
    @latest = Message.import_latest
    puts "Latest transactions processed and imported at #{Time.now}"
  end
