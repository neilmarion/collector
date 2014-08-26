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
            pr = PhotoRandomizer.new(params[:album_id], params[:device])
            photo = pr.photo
            prev_current_next = photo.prev_current_next
          else
            photo = album.photos.order('created_at DESC').first
            prev_current_next = photo.prev_current_next
          end
        else
          id  = params[:id]
          photo = Photo.find(id) || Photo.find(id).album.first
          prev_current_next = photo.prev_current_next
        end
        photo.album.devices.where(mac_address: params[:device]).first_or_create.has_read(prev_current_next[:current][:id]) if params[:device] && !params[:device].blank?
        prev_current_next
      end
    end

    resource :new_ids do
      get do
        Album.find(params[:album_id]).new_ids
      end
    end

    resource :month do
      get do
        Time.now.month
      end
    end

    resource :announcements do
      get do
        Album.find(params[:album_id]).announcements.first.message
      end
    end
  end
end
