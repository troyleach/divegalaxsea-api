# frozen_string_literal: true

require 'rails_helper'
RSpec.describe API::V1::GoogleDriveImagesController, type: :controller do
  before do
    # sign_in_user(admin_user)
  end

  # TODO: watch this vid yo
  # https://www.youtube.com/watch?v=Okck4Fc557o

  describe 'GET /v1/usergoogle_drive_imagess' do
    describe 'Positive results' do
      before(:each) do
        # Stub the google drive module
        # really does not matter what the endpoint returns, that is tested else where
        allow(Image)
          .to receive(:images)
          .and_return({ 'name' => 'Hello' })

        get :index
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    describe 'Negitive results' do
      before(:each) do
        allow(Image)
          .to receive(:images)
          .and_raise(RuntimeError.new('missing client_email'))
        get :index
      end

      it 'returns status code 400 bad requese' do
        expected_json = { "status": 400,
                          "error": 'run_time_error',
                          "message": 'missing client_email' }
        expect(response).to have_http_status(400)
        expect(json).to eq(
          expected_json.as_json
        )
      end
    end
  end
end
