# frozen_string_literal: true

# FIXME: make this file reservations
class API::V1::VacationsController < ApplicationController
  # FIXME: this seems very very bad
  # https://appsignal.com/for/invalid_authenticity_token
  # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_vacation, only: %i[show update destroy]
  before_action :find_or_create_user, only: %i[create]

  def index
    vacations = Vacation.all
    render json: vacations, status: 200
  end

  def show
    render json: @vacation, status: 200
  end

  def create
    vacation = Vacation.new(vacation_params)

    if vacation.save
      render json: vacation, status: 201
    else
      render_json_validation_error vacation
    end
  end

  def update
    if @vacation.update(vacation_params)
      render json: { message: 'Vacation successfully updated' }, status: 204
    else
      render_json_error vacation, { id: params[:id] }
    end
  end

  def destroy
    return unless @vacation.destroy!
  end

  private

  def set_vacation
    # not positive this is the best solution or if this is the 'rails' way
    @vacation = Vacation.find(params[:id]) if params[:id]
  end

  def find_or_create_user
    user = User.create_with(params['user'].as_json).find_or_create_by(email: params['user']['email'])
    params['vacation'].merge!(user_id: user.id)
  end

  def vacation_params
    # Dates array must be LAST!!
    params.require(:vacation).permit(
      :user_id,
      :number_of_divers,
      :resort,
      diving_objects: %i[id title price description],
      training_objects: %i[id title price description],
      dates_array: []
    )
  end
end
