namespace :collect do
  task :photos => :environment do
    ALBUMS.each do |album|
      a = Album.create({name: album["name"], fb_id: album["fb_id"]})
      get_photos(album["fb_id"], a.id)
    end
  end
end

def get_photos(fb_id, album_id)
  puts "Accessing Facebook..."
  url = "https://graph.facebook.com/oauth/access_token?client_id=#{FB['key']}&client_secret=#{FB['secret']}&grant_type=client_credentials"
  access_token_io = open(url)
  puts "Generating access token..."
  access_token = access_token_io.gets
  url = "https://graph.facebook.com/v2.0/#{fb_id}/photos?#{access_token}"

  CollectorWorker.perform_async(url, access_token, album_id)
end
