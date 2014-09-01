namespace :update do
  task :small_photos, [:album_id] => :environment do |t, args|
    album = Album.find(args[:album_id])
    update_small_photos(album)
  end
end

def update_small_photos(album)
  puts "hello"
  puts "Accessing Facebook..."
  url = "https://graph.facebook.com/oauth/access_token?client_id=#{FB['key']}&client_secret=#{FB['secret']}&grant_type=client_credentials"
  access_token_io = open(url)
  puts "Generating access token..."
  access_token = access_token_io.gets


  album.photos.each do |photo|
    url = "https://graph.facebook.com/v2.1/#{photo.fb_id}?#{access_token}"
    SmallPhotosWorker.perform_async(url, access_token, photo.id)
  end
end
