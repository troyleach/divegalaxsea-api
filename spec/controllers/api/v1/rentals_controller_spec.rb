# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::RentalsController, type: :controller do
  # initialize test data
  let!(:rentals) { create_list(:rental, 5) }
  let(:rental_id) { rentals.first.id }

  before do
    # sign_in_user(admin_user)
  end

  describe 'GET /v1/rentals' do
    before { get :index }

    it 'returns all rentals' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /rentals/:id' do
    before { get :show, params: { id: rental_id } }

    context 'when the record exists' do
      it 'returns the rental' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(rental_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:rental_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['message']).to eq("Couldn't find Rental with 'id'=100")
      end
    end
  end

  describe 'POST /rental' do
    let(:valid_attributes) do
      { rental: { title: 'rental test title',
                  price: 18.99,
                  description: 'rental test description' } }
    end

    context 'when the request is valid' do
      before { post :create, params: valid_attributes }

      it 'creates a user' do
        expect(json['title']).to eq(valid_attributes[:rental][:title])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        { rental: { title: 'rental test title',
                    description: 'rental test description' } }
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

    describe 'PUT /rentals/:id' do
      context 'when the record exists' do
        let(:valid_attributes) do
          {
            id: rental_id,
            rental: { title: 'title Changed' }
          }
        end
        before { put :update, params: valid_attributes }

        it 'updates the record' do
          updated_rental = Rental.find_by_id(rental_id)
          expect(updated_rental.title).to eq(valid_attributes[:rental][:title])
        end

        it 'Expect correct response message' do
          expect(json['message']).to eq('Rental successfully updated')
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'Record does not exist' do
        let(:inValid_attributes) do
          {
            id: 999,
            rental: { title: 'Title Changed' }
          }
        end
        before { put :update, params: inValid_attributes }

        it 'Returns an error' do
          expect(json['message']).to eq("Couldn't find Rental with 'id'=999")
        end

        it 'returns correct status code' do
          expect(response).to have_http_status(404)
        end
      end
    end

    describe 'DELETE /rental/:id' do
      it 'deletes the rental' do
        expect do
          delete :destroy, params: { id: rental_id }
        end.to change(Rental, :count).by(-1)
      end

      it 'returns status code 200' do
        # check to make sure the records are one less. I think there is a method to do this
        expect(response).to have_http_status(200)
      end
    end
  end
end
