# frozen_string_literal: true

# Error module to Handle errors globally
# Refactored ErrorHandler to handle multiple errors
# Rescue StandardError acts as a Fallback mechanism to handle any exception
# https://medium.com/rails-ember-beyond/error-handling-in-rails-the-modular-way-9afcddd2fe1b
# https://github.com/scaffeinate/modular-error-handling
module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from StandardError do |e|
          respond(:standard_error, 500, e.to_s)
        end

        rescue_from RuntimeError do |e|
          respond(:run_time_error, 400, e.to_s)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:record_not_found, 404, e.to_s)
        end
        # rescue_from CustomError do |e|
        #   respond(e.error, e.status, e.message.to_s)
        # end
      end
    end

    def render_json_validation_error(resource)
      render json: resource, status: :bad_request, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end

    class CusteomError; end

    private

    def respond(error, status, message)
      json = Helpers::Render.json(error, status, message)
      render json: json, status: status
    end
  end
end
