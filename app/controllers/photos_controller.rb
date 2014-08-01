class PhotosController < ApplicationController
  def index
    unless params["album_id"]
      @photos = Photo.page(params[:page])
    else
      @photos = Album.find(params[:album_id]).photos.page(params[:page])
    end
  end
end
