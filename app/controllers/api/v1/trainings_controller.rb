# frozen_string_literal: true

class API::V1::TrainingsController < ApplicationController
  # FIXME: this seems very very bad
  # https://appsignal.com/for/invalid_authenticity_token
  # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    trainings = Training.all
    # what is adapter: json_api
    # render json: users, adapter: :json_api, status: 200
    render json: trainings, status: 200
  end

  def show
    training = Training.find(params[:id])
    render json: training, status: 200
  end

  def create
    training = Training.new(training_params)
    if training.save
      render json: training, status: 201
    else
      render_json_validation_error training
    end
  end

  def update
    training = Training.find(params[:id])
    if training.update(training_params)
      render json: { message: 'Training successfully updated' }, status: 204
    else
      render_json_error user, { id: params[:id] }
    end
  end

  def destroy
    training = Training.find(params[:id])
    render json: training, adapter: :json_api, status: 200 if training.destroy!
  end

  private

  def training_params
    params.require(:training).permit(:title, :price, :description)
  end
end
