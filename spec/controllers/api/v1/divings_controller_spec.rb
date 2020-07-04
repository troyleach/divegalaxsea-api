# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::DivingsController, type: :controller do
  # initialize test data
  let!(:divings) { create_list(:diving, 5) }
  let(:diving_id) { divings.first.id }

  before do
    # sign_in_user(admin_user)
  end

  describe 'GET /v1/divings' do
    before { get :index }

    it 'returns divings' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /divings/:id
  describe 'GET /divings/:id' do
    before { get :show, params: { id: diving_id } }

    context 'when the record exists' do
      it 'returns the diving' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(diving_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:diving_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['errors'][0].keys.include?('diving_id')).to be(true)
        expect(json['errors'][0]['title']).to match('Could not find diving')
      end
    end
  end

  describe 'POST /divings' do
    let(:valid_attributes) do
      { diving: { title: 'test title',
                  price: 18.99,
                  description: 'test description' } }
    end

    context 'when the request is valid' do
      before { post :create, params: valid_attributes }

      it 'creates a diving' do
        new_diving_record = Diving.all.last
        expect(new_diving_record.title).to eq(valid_attributes[:diving][:title])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        { diving: { title: 'Test Title' } }
      end

      before { post :create, params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(json['errors'][0]['detail'])
          .to include("can't be blank")
        # TODO: I would really like this to say Price can't be blank, need to high jack validation error
      end
    end
  end

  # Test suite for PUT /divings/:id
  describe 'PUT /divings/:id' do
    context 'when the record exists' do
      let(:valid_attributes) do
        {
          id: diving_id,
          diving: { price: 20.99 }
        }
      end
      before { put :update, params: valid_attributes }

      it 'updates the record' do
        updated_diving = Diving.find_by_id(diving_id)
        expect(updated_diving.price).to eq(valid_attributes[:diving][:price])
      end

      it 'Expect correct response message' do
        expect(json['message']).to eq('Diving successfully updated')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'Record does not exist' do
      let(:inValid_attributes) do
        {
          id: 999,
          diving: { title: 'Changed test title' }
        }
      end
      before { put :update, params: inValid_attributes }

      it 'Returns an error' do
        expect(json['errors'][0]['title']).to eq('Could not find diving')
        expect(json['errors'][0]['diving_id']).to eq(inValid_attributes[:id].to_s)
      end

      it 'returns correct status code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /divings/:id' do
    it 'deletes the diving' do
      expect do
        delete :destroy, params: { id: diving_id }
      end.to change(Diving, :count).by(-1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
