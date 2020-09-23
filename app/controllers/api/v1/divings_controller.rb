# frozen_string_literal: true

class API::V1::DivingsController < ApplicationController
  # FIXME: this seems very very bad
  # https://appsignal.com/for/invalid_authenticity_token
  # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    divings = Diving.all
    render json: divings, adapter: :json_api, status: 200
  end

  def show
    diving = Diving.find(params[:id])
    render json: diving, status: 200
  end

  def create
    diving = Diving.new(diving_params)
    if diving.save
      render json: diving, status: 201
    else
      render_json_validation_error diving
    end
  end

  def update
    diving = Diving.find(params[:id])
    if diving.update(diving_params)
      render json: { message: 'Diving successfully updated' }, status: 204
    else
      render_json_error user, { id: params[:id] }
    end
  end

  def destroy
    diving = Diving.find(params[:id])
    render json: diving, adapter: :json_api, status: 200 if diving.destroy!
  end

  private

  def diving_params
    params.require(:diving).permit(:title, :price, :description)
  end
end
