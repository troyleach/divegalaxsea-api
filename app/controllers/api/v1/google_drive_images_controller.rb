# frozen_string_literal: true

require_relative '../../../lib/google_drive/gDrive.rb'

class API::V1::GoogleDriveImagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |event|
    render_json_error :not_found, :user_not_found, { user_id: event.id }
  end

  def index
    # what is adapter: json_api
    # render json: users, adapter: :json_api, status: 200

    images = Image.images
    render json: images, status: 200
  rescue StandardError => e
    print "this is the ERROR YO #{e}"
    render json: e, status: 500
  end
end
