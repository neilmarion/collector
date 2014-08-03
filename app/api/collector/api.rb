require 'grape'

module Collector
  class API < Grape::API
    version 'v1', using: :header, vendor: 'neilmarion'
    format :json

    resource :show do
      get do
        if params[:album_id]
          album = Album.find(params[:album_id])
          album.photos.first.prev_current_next
        else
          id  = params[:id]
          Photo.find(id).prev_current_next || Photo.find(id).album.first.prev_current_next
        end
      end
    end

  end
end
