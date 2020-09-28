# frozen_string_literal: true

# require_relative '../../../lib/google_drive/gDrive.rb'

class API::V1::GoogleDriveImagesController < ApplicationController
  def index
    # images = Image.images
    images = {"message": "this is images"}
    render json: images, status: 200
  end
end
