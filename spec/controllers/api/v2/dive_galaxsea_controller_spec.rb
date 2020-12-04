# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V2::DiveGalaxseaController, type: :controller do
  # initialize test data

  before do
    # sign_in_user(admin_user)
  end

  describe 'GET /v2' do
    before { get :index }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    xit 'returns the correct keys' do
      keys = %w[users divings miscellaneous_pricings specialties trainings reservations]
      expect(response.keys).should match_array(keys)
    end
  end
end
