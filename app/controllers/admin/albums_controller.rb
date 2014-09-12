class Admin::AlbumsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @advertisements = @album.advertisements
    @photos = @album.photos.order('created_at DESC').page(params[:page])
  end
end
