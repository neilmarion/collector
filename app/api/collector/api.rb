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
            prev_current_next = photo.prev_current_next(pr)
          else
            photo = album.photos.order('created_at DESC').first
            pr = PhotoRandomizer.new(photo.album_id, params[:device])
            prev_current_next = photo.prev_current_next(pr)
          end
        else
          id  = params[:id]
          photo = Photo.find(id) || Photo.find(id).album.first
          pr = PhotoRandomizer.new(photo.album_id, params[:device])
          prev_current_next = photo.prev_current_next(pr)
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

    resource :getadvertisement do
      get do
        ar = AdvertisementRandomizer.new(params[:album_id])
        advertisement = ar.advertisement
        { :photo => advertisement.photo_url, :link => advertisement.link }
      end
    end

    resource :enablepushnotifications do
      post do
        album = Album.find(params[:album_id])
        device = album.devices.where(mac_address: params[:device], reg_id: params[:reg_id], platform: params[:platform]).first_or_create
        if params[:enable]
          device.enable_push_notifications
          { :message => "Push notifications enabled"}
        else
          device.disable_push_notifications
          { :message => "Push notifications disabled"}
        end
      end
    end
  end
end
