namespace :collect do
  task :photos => :environment do
    get_first_page_photos
  end
end

def get_first_page_photos
  puts "Accessing Facebook..."
  url = "https://graph.facebook.com/oauth/access_token?client_id=#{FB['key']}&client_secret=#{FB['secret']}&grant_type=client_credentials"
  access_token_io = open(url)
  puts "Generating access token..."
  a = access_token_io.gets
  url = "https://graph.facebook.com/v2.0/257558077593647/photos?#{a}"
  puts "Grabbing the first page of the album..."
  first_page_posts = JSON.parse(open(URI.encode(url)).read)
  puts first_page_posts
end
