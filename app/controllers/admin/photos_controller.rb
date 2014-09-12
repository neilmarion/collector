class Admin::PhotosController < ApplicationController
  def update_show
    Photo.find(params[:id]).toggle(:show).save!
  end
end
