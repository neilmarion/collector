class Admin::AlbumsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @advertisements = @album.advertisements
  end
end
