# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::SpecialtiesController, type: :controller do
  # initialize test data
  let!(:specialties) { create_list(:specialty, 5) }
  let(:specialty_id) { specialties.first.id }

  before do
    # sign_in_user(admin_user)
  end

  describe 'GET /v1/specialties' do
    before { get :index }

    it 'returns all specialties' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /specialties/:id' do
    before { get :show, params: { id: specialty_id } }

    context 'when the record exists' do
      it 'returns the specialty' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(specialty_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:specialty_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['message']).to eq("Couldn't find Specialty with 'id'=100")
      end
    end
  end

  describe 'POST /specialty' do
    let(:valid_attributes) do
      { specialty: { title: 'rental test title',
                     price: 18.99,
                     description: 'specialty test description' } }
    end

    context 'when the request is valid' do
      before { post :create, params: valid_attributes }

      it 'creates a specialty' do
        expect(json['title']).to eq(valid_attributes[:specialty][:title])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before(:all) do
        @valid_object = { specialty: { title: 'specialty test title',
                                       description: 'specialty test description' } }
      end

      before { post :create, params: @valid_object }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(json['errors'][0]['detail'])
          .to include("can't be blank")
      end
    end

    describe 'PUT /specialties/:id' do
      context 'when the record exists' do
        let(:valid_attributes) do
          {
            id: specialty_id,
            specialty: { title: 'title Changed' }
          }
        end
        before { put :update, params: valid_attributes }

        it 'updates the record' do
          updated_specialty = Specialty.find_by_id(specialty_id)
          expect(updated_specialty.title).to eq(valid_attributes[:specialty][:title])
        end

        it 'Expect correct response message' do
          expect(json['message']).to eq('Specialty successfully updated')
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'Record does not exist' do
        let(:inValid_attributes) do
          {
            id: 999,
            specialty: { title: 'Title Changed' }
          }
        end
        before { put :update, params: inValid_attributes }

        it 'Returns an error' do
          expect(json['message']).to eq("Couldn't find Specialty with 'id'=999")
        end

        it 'returns correct status code' do
          expect(response).to have_http_status(404)
        end
      end
    end

    describe 'DELETE /specialty/:id' do
      it 'deletes the specialty' do
        expect do
          delete :destroy, params: { id: specialty_id }
        end.to change(Specialty, :count).by(-1)
      end

      it 'returns status code 200' do
        # check to make sure the records are one less. I think there is a method to do this
        expect(response).to have_http_status(200)
      end
    end
  end
end
