require 'grape'

module Collector
  class API < Grape::API
    version 'v1', using: :header, vendor: 'neilmarion'
    format :json

    resource :show do
      get do
        if params[:album_id]
          album = Album.find(params[:album_id])
          album.first
        else
          direction = params[:direction]
          id  = params[:id]
          photo = if params[:direction] == "next"
            Photo.find(id).next || Photo.find(id).album.first
          else
            Photo.find(id).prev || Photo.find(id).album.last
          end
          photo
        end
      end
    end

  end
end
