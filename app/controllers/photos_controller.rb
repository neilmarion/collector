class PhotosController < ApplicationController
  def index
    @photos = Photo.page(params[:page])
  end
end
