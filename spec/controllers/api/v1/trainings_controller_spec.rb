# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::TrainingsController, type: :controller do
  # initialize test data
  let!(:trainings) { create_list(:training, 5) }
  let(:training_id) { trainings.first.id }

  before do
    # sign_in_user(admin_user)
  end

  describe 'GET /v1/trainings' do
    before { get :index }

    it 'returns trainings' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /trainings/:id' do
    before { get :show, params: { id: training_id } }

    context 'when the record exists' do
      it 'returns the training' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(training_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:training_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['message']).to eq("Couldn't find Training with 'id'=100")
      end
    end
  end

  describe 'POST /training' do
    let(:valid_attributes) do
      { training: { title: 'training test title',
                    price: 18.99,
                    description: 'training test description' } }

      context 'when the request is valid' do
        before { post :create, params: valid_attributes }

        it 'creates a user' do
          expect(json['training']['title']).to eq(valid_attributes[:training[:title]])
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        let(:invalid_attributes) do
          { training: { title: 'training test title',
                        description: 'training test description' } }
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
    end

    describe 'PUT /trainings/:id' do
      context 'when the record exists' do
        let(:valid_attributes) do
          {
            id: training_id,
            training: { title: 'title Changed' }
          }
        end
        before { put :update, params: valid_attributes }

        it 'updates the record' do
          updated_training = Training.find_by_id(training_id)
          expect(updated_training.title).to eq(valid_attributes[:training][:title])
        end

        it 'Expect correct response message' do
          expect(json['message']).to eq('Training successfully updated')
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'Record does not exist' do
        let(:inValid_attributes) do
          {
            id: 999,
            training: { title: 'Title Changed' }
          }
        end
        before { put :update, params: inValid_attributes }

        it 'Returns an error' do
          expect(json['message']).to eq("Couldn't find Training with 'id'=999")
        end

        it 'returns correct status code' do
          expect(response).to have_http_status(404)
        end
      end
    end

    describe 'DELETE /users/:id' do
      it 'deletes the user' do
        expect do
          delete :destroy, params: { id: training_id }
        end.to change(Training, :count).by(-1)
      end

      it 'returns status code 200' do
        # check to make sure the records are one less. I think there is a method to do this
        expect(response).to have_http_status(200)
      end
    end
  end
end
