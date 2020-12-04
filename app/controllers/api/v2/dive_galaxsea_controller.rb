
# frozen_string_literal: true

class API::V2::DiveGalaxseaController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    data = 'this will be a big data_tree '
    render json: data, adapter: :json_api, status: 200
  end
end
