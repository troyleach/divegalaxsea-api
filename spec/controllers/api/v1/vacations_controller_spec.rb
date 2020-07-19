# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::VacationsController, type: :controller do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:user_two) { create(:user) }
  let!(:vacation) { create(:vacation, user_id: user.id) }
  let!(:vacationTwo) { create(:vacation, user_id: user_two.id) }
  let(:vacation_id) { vacation.id }

  before do
    # sign_in_user(admin_user)
  end

  describe 'GET /v1/vacations' do
    before { get :index }

    it 'returns vacations' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /vacations/:id' do
    before { get :show, params: { id: vacation_id } }

    context 'when the record exists' do
      it 'returns the vacation' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(vacation_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:vacation_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['message']).to eq("Couldn't find Vacation with 'id'=100")
      end
    end
  end

  describe 'POST /vacation' do
    let(:user) { create(:user) }
    let(:dates) { [(Date.today + 1.day), (Date.today + 1.day)].map(&:to_s) }
    let(:valid_attributes) do
      { vacation: { user_id: user.id,
                    dates_array: dates,
                    diving_objects: [{ title: 'title of diving', price: 10.99, description: 'diving description' }],
                    training_objects: [{ title: 'title of training', price: 11.99 }, { title: 'title of training', price: 9.99, description: 'training description' }],
                    number_of_divers: 5,
                    resort: 'Test resort name' } }
    end

    context 'when the request is valid' do
      before { post :create, params: valid_attributes }
      # FIXME: I have to make a through table so that i can save ids NOT the objects
      it 'creates a vacation' do
        expect(json['user_id'])
          .to eq(user.id)
        expect(json['dates_array'])
          .to eq(dates)
        expect(json['training_objects'].size)
          .to eq(valid_attributes[:vacation][:training_objects].size)
        expect(json['diving_objects'].size)
          .to eq(valid_attributes[:vacation][:diving_objects].size)
        expect(json['number_of_divers'])
          .to eq(5)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        { vacation: { user_id: user.id,
                      dates_array: [Time.now.utc],
                      diving_objects: [{ title: 'title of diving' }],
                      training_objects: [{ training: 'test training objects' }],
                      number_of_divers: 5 } }
      end

      before { post :create, params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        # FIXME: make sure this returns a usefully error
        expect(json['errors'][0]['detail'])
          .to include("can't be blank")
      end
    end

    describe 'PUT /vacations/:id' do
      context 'when the record exists' do
        let(:valid_attributes) do
          {
            id: vacation_id,
            vacation: { resort: 'Change resort name' }
          }
        end
        before { put :update, params: valid_attributes }

        it 'updates the record' do
          updated_vacation = Vacation.find_by_id(vacation_id)
          expect(updated_vacation.resort).to eq(valid_attributes[:vacation][:resort])
        end

        it 'Expect correct response message' do
          expect(json['message']).to eq('Vacation successfully updated')
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'Record does not exist' do
        let(:inValid_attributes) do
          {
            id: 999,
            vacation: { resort: 'Change resort name' }
          }
        end
        before { put :update, params: inValid_attributes }

        it 'Returns an error' do
          expect(json['message']).to eq("Couldn't find Vacation with 'id'=999")
        end

        it 'returns correct status code' do
          expect(response).to have_http_status(404)
        end
      end
    end

    describe 'DELETE /vacations/:id' do
      it 'deletes the training' do
        expect do
          delete :destroy, params: { id: vacation_id }
        end.to change(Vacation, :count).by(-1)
      end

      it 'returns status code 200' do
        # check to make sure the records are one less. I think there is a method to do this
        expect(response).to have_http_status(200)
      end
    end
  end
end