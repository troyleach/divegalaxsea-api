# frozen_string_literal: true

class API::V1::MiscellaneousPricingController < ApplicationController
  # FIXME: this seems very very bad
  # https://appsignal.com/for/invalid_authenticity_token
  # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :load_miscellaneous_pricing

  def index
    miscellaneous_pricing = MiscellaneousPricing.all
    # what is adapter: json_api
    # render json: users, adapter: :json_api, status: 200
    render json: miscellaneous_pricing, status: 200
  end

  def show
    render json: @miscellaneous_pricing, status: 200
  end

  def create
    miscellaneous_pricing = MiscellaneousPricing.new(miscellaneous_pricing_params)
    if miscellaneous_pricing.save
      render json: miscellaneous_pricing, status: 201
    else
      render_json_validation_error miscellaneous_pricing
    end
  end

  def update
    if @miscellaneous_pricing.update(miscellaneous_pricing_params)
      render json: { message: 'Miscellaneous Pricing successfully updated' }, status: 204
    else
      render_json_error @miscellaneous_pricing, { id: params[:id] }
    end
  end

  def destroy
    if @miscellaneous_pricing.destroy!
      render json: @miscellaneous_pricing, adapter: :json_api, status: 200
    end
  end

  private

  def load_miscellaneous_pricing
    # not positive this is the best solution or if this is the 'rails' way
    if params[:id]
      @miscellaneous_pricing = MiscellaneousPricing.find(params[:id])
    end
  end

  def miscellaneous_pricing_params
    params.require(:miscellaneous_pricing).permit(:title, :price, :description)
  end
end
