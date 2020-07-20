# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::MiscellaneousPricingController, type: :controller do
  # initialize test data
  let!(:miscellaneousPricings) { create_list(:miscellaneousPricing, 5) }
  let(:miscellaneousPricing_id) { miscellaneousPricings.first.id }

  before do
    # sign_in_user(admin_user)
  end

  describe 'GET /v1/miscellaneous_pricings' do
    before { get :index }

    it 'returns all miscellaneous_pricings' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /miscellaneous_pricings/:id' do
    before { get :show, params: { id: miscellaneousPricing_id } }

    context 'when the record exists' do
      it 'returns the miscellaneous_pricing' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(miscellaneousPricing_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:miscellaneousPricing_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['message']).to eq("Couldn't find MiscellaneousPricing with 'id'=100")
      end
    end
  end

  describe 'POST /miscellaneous_pricing' do
    let(:valid_attributes) do
      { miscellaneous_pricing: { title: 'rental test title',
                                 price: 18.99,
                                 description: 'miscellaneous_pricing test description' } }
    end

    context 'when the request is valid' do
      before { post :create, params: valid_attributes }

      it 'creates a miscellaneous_pricing' do
        expect(json['title']).to eq(valid_attributes[:miscellaneous_pricing][:title])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        { miscellaneous_pricing: { title: 'rental test title',
                                   description: 'miscellaneous_pricing test description' } }
      end

      before { post :create, params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(json['errors'][0]['detail'])
          .to include("can't be blank")
      end
    end

    describe 'PUT /miscellaneous_pricing/:id' do
      context 'when the record exists' do
        let(:valid_attributes) do
          {
            id: miscellaneousPricing_id,
            miscellaneous_pricing: { title: 'title Changed' }
          }
        end
        before { put :update, params: valid_attributes }

        it 'updates the record' do
          updated_miscellaneous_pricing = MiscellaneousPricing.find_by_id(miscellaneousPricing_id)
          expect(updated_miscellaneous_pricing.title).to eq(valid_attributes[:miscellaneous_pricing][:title])
        end

        it 'Expect correct response message' do
          expect(json['message']).to eq('Miscellaneous Pricing successfully updated')
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'Record does not exist' do
        let(:inValid_attributes) do
          {
            id: 999,
            miscellaneous_pricing: { title: 'Title Changed' }
          }
        end
        before { put :update, params: inValid_attributes }

        it 'Returns an error' do
          expect(json['message']).to eq("Couldn't find MiscellaneousPricing with 'id'=999")
        end

        it 'returns correct status code' do
          expect(response).to have_http_status(404)
        end
      end
    end

    describe 'DELETE /miscellaneous_pricing/:id' do
      it 'deletes the Miscellaneous Pricing' do
        expect do
          delete :destroy, params: { id: miscellaneousPricing_id }
        end.to change(MiscellaneousPricing, :count).by(-1)
      end

      it 'returns status code 200' do
        # check to make sure the records are one less. I think there is a method to do this
        expect(response).to have_http_status(200)
      end
    end
  end
end
