# frozen_string_literal: true

class API::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name
end
