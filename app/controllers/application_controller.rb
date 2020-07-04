# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def render_json_error(status, error_code, extra = {})
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

    error = {
      title: I18n.t("error_messages.#{error_code}.title"),
      status: status,
      code: I18n.t("error_messages.#{error_code}.code")
    }.merge(extra)

    detail = I18n.t("error_messages.#{error_code}.detail", default: '')
    error[:detail] = detail unless detail.empty?

    render json: { errors: [error] }, status: status
  end

  def render_json_validation_error(resource)
    render json: resource, status: :bad_request, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
