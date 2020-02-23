# frozen_string_literal: true

class API::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :display_info

  def display_info
    {
      display_name: "#{object.first_name} #{object.last_name}"
    }
  end
end
