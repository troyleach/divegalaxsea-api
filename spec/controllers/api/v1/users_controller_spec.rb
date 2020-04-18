# frozen_string_literal: true

require 'rails_helper'
# include SignIn // Have not made this yet

RSpec.describe API::V1::UsersController, type: :controller do
  describe 'GET #index' do
    before do
      # sign_in_user(admin_user)
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'Returns json object' do
    end
    it 'Returns a user' do
      user = create(:user)
      get :index
      parsed_response = JSON.parse(response.body)['data'][0]['attributes']
      expect(parsed_response['first_name']).to eq(user.first_name)
      expect(parsed_response['last_name']).to eq(user.last_name)
    end
  end
end
