# frozen_string_literal: true

class API::V1::RentalsController < ApplicationController
  # FIXME: this seems very very bad
  # https://appsignal.com/for/invalid_authenticity_token
  # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :load_rental

  def index
    rentals = Rental.all
    # what is adapter: json_api
    # render json: users, adapter: :json_api, status: 200
    render json: rentals, status: 200
  end

  def show
    render json: @rental, status: 200
  end

  def create
    rental = Rental.new(training_params)
    if rental.save
      render json: rental, status: 201
    else
      render_json_validation_error rental
    end
  end

  def update
    if @rental.update(rental_params)
      render json: { message: 'Rental successfully updated' }, status: 204
    else
      render_json_error @rental, { id: params[:id] }
    end
  end

  def destroy
    render json: @rental, adapter: :json_api, status: 200 if @rental.destroy!
  end

  private

  def load_rental
    # not positive this is the best solution or if this is the 'rails' way
    @rental = Rental.find(params[:id]) if params[:id]
  end

  def rental_params
    params.require(:rental).permit(:title, :price, :description)
  end
end
