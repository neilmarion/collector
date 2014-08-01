class PhotosController < ApplicationController
  def index
    unless params["album_id"]
      @photos = Photo.order('created_at DESC').page(params[:page])
    else
      @photos = Album.find(params[:album_id]).photos.order('created_at DESC').page(params[:page])
    end
  end
end
