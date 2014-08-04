require 'grape'

module Collector
  class API < Grape::API
    version 'v1', using: :header, vendor: 'neilmarion'
    format :json

    resource :show do
      get do
        if params[:album_id]
          album = Album.find(params[:album_id])
          if params[:random]
            album.random.prev_current_next
          else
            album.photos.order('created_at DESC').first.prev_current_next
          end
        else
          id  = params[:id]
          Photo.find(id).prev_current_next || Photo.find(id).album.first.prev_current_next
        end
      end
    end

    resource :new_ids do
      get do
        Album.find(params[:album_id]).new_ids
      end
    end

    resource :month do
      get do
        1
      end
    end
  end
end
