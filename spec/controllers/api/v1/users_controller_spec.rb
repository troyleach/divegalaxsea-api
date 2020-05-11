# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::UsersController, type: :controller do
  # initialize test data
  let!(:users) { create_list(:user, 5) }
  let(:user_id) { users.first.id }

  before do
    # sign_in_user(admin_user)
  end

  # Test suite for GET /users
  describe 'GET /v1/users' do
    before { get :index }
    # before { get '/v1/users' }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /userss/:id
  describe 'GET /users/:id' do
    before { get :show, params: { id: user_id } }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(user_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for POST /users
  describe 'POST /users' do
    # valid payload
    let(:valid_attributes) do
      { user: { first_name: 'Test',
                last_name: 'Name',
                email: 'test.name@email.com' } }
    end

    context 'when the request is valid' do
      before { post :create, params: valid_attributes }

      it 'creates a user' do
        expect(json['data']['attributes']['first_name']).to eq('Test')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        { user: { first_name: 'Test',
                  last_name: 'Name' } }
      end

      before { post :create, params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['email'])
          .to include("can't be blank")
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /users/:id' do
    let(:valid_attributes) do
      {
        id: user_id,
        user: { first_name: 'Changed' }
      }
    end

    context 'when the record exists' do
      before { put :update, params: valid_attributes }

      it 'updates the record' do
        updated_user = User.find_by_id(user_id)
        expect(updated_user.first_name).to eq(valid_attributes[:user][:first_name])
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete :delete, params: { id: user_id } }

    it 'returns status code 204' do
      # check to make sure the records are one less. I think there is a method to do this
      expect(response).to have_http_status(204)
    end
  end
end
