# frozen_string_literal: true

class API::V1::GoogleDriveImagesController < ApplicationController
  def index
    images = Image.images
    render json: images, status: 200
  end
end
