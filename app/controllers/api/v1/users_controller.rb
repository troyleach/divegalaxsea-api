# frozen_string_literal: true

class API::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    users = User.all
    render json: users, adapter: :json_api, status: 200
  end

  def show
    user = User.find(params[:id])
    render json: user, adapter: :json_api, status: 200
  end

  def create
    user = User.new(user_params)
    render json: user, adapter: :json_api, status: 200 if user.save!
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, adapter: :json_api, status: 200
    end
  end

  def destroy
    user = User.find(params[:id])
    render json: user, adapter: :json_api, status: 200 if user.destroy!
  end

  private

  def record_not_found
    render json: { message: 'Record Not Found!' }, adapter: :json_api, status: 404
  end
end
