# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::UserSerializer, type: :serializer do
  let(:user) { create(:user) }

  it '#display_info' do
    serialized_user = API::V1::UserSerializer.new(user)
    expect(serialized_user.display_info[:display_name]).to eql("#{user.first_name} #{user.last_name}")
  end
end
