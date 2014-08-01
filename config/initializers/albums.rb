ALBUMS = YAML.load_file("#{::Rails.root}/config/albums.yml")[::Rails.env]["albums"]
