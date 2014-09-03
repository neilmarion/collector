class Admin::AdvertisementsController < ApplicationController
  def new
    @album = Album.find(params[:album_id])
    @advertisement = @album.advertisements.new
  end

  def show

  end

  def create
    @product = Advertisement.new(product_params)
    @product.save
    redirect_to admin_album_path(params[:album_id])
  end

  private

  def product_params
     params.require(:advertisement).permit(:text, :photo, :album_id, :link)
  end
end
