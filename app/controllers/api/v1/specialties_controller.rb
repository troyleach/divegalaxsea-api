# frozen_string_literal: true

class API::V1::SpecialtiesController < ApplicationController
  # FIXME: this seems very very bad
  # https://appsignal.com/for/invalid_authenticity_token
  # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :load_specialty

  def index
    specialties = Specialty.all
    # what is adapter: json_api
    # render json: users, adapter: :json_api, status: 200
    render json: specialties, status: 200
  end

  def show
    render json: @specialty, status: 200
  end

  def create
    specialty = Specialty.new(specialty_params)
    if specialty.save
      render json: specialty, status: 201
    else
      render_json_validation_error specialty
    end
  end

  def update
    if @specialty.update(specialty_params)
      render json: { message: 'Specialty successfully updated' }, status: 204
    else
      render_json_error @rental, { id: params[:id] }
    end
  end

  def destroy
    if @specialty.destroy!
      render json: @specialty, adapter: :json_api, status: 200
    end
  end

  private

  def load_specialty
    # not positive this is the best solution or if this is the 'rails' way
    @specialty = Specialty.find(params[:id]) if params[:id]
  end

  def specialty_params
    params.require(:specialty).permit(:title, :price, :description)
  end
end
