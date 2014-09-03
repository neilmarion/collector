class Admin::AlbumsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @albums = Album.all
  end

  def show
  end
end
