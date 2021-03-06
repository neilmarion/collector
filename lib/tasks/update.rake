namespace :update do
  task :photos => :environment do
    Album.all.each do |album|
      update_photos(album.id)
    end
  end
end

def update_photos(album_id)
  puts "Accessing Facebook..."
  url = "https://graph.facebook.com/oauth/access_token?client_id=#{FB['key']}&client_secret=#{FB['secret']}&grant_type=client_credentials"
  access_token_io = open(url)
  puts "Generating access token..."
  access_token = access_token_io.gets
  url = "https://graph.facebook.com/v2.0/#{Album.find(album_id).fb_id}/photos?#{access_token}"

  UpdaterWorker.perform_async(url, access_token, album_id)
end
