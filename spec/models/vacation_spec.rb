# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vacation, type: :model do
  before(:all) do
    @user = create(:user)
  end
  it 'has a valid factory' do
    expect(build(:vacation, user_id: @user.id)).to be_valid
  end

  let(:vacation) { create(:vacation, user_id: @user.id) }

  describe 'Database columns/indexes' do
    it { expect(vacation).to have_db_column(:user_id).of_type(:integer) }
    it { expect(vacation).to have_db_column(:dates_array) }
    it { expect(vacation).to have_db_column(:diving_objects).of_type(:jsonb).with_options(null: true) }
    it { expect(vacation).to have_db_column(:training_objects).of_type(:jsonb).with_options(null: true) }
    it { expect(vacation).to have_db_column(:number_of_divers).of_type(:integer) }
    it { expect(vacation).to have_db_column(:resort).of_type(:string) }
  end

  describe 'Validations' do
    it { expect(vacation).to validate_presence_of(:user_id).with_message(/can't be blank/) }
    it { expect(vacation).to validate_presence_of(:dates_array).with_message(/can't be blank/) }
    it { expect(vacation).to validate_presence_of(:resort).with_message(/can't be blank/) }
  end

  describe 'Vacation Model' do
    describe 'valid' do
      it 'Vacation is valid with out training' do
        vacation = Vacation.new(user_id: @user.id,
                                dates_array: [Time.now.utc],
                                diving_objects: [{ "title": 'title of diving' }],
                                number_of_divers: 5,
                                resort: 'Test resort name')
        expect(vacation).to be_valid
      end

      it 'Vacation is valid, with training' do
        vacation = Vacation.new(user_id: 1,
                                dates_array: [Time.now.utc],
                                diving_objects: [{ diving: 'test diving objects' }],
                                training_objects: [{ training: 'test training objects' }],
                                number_of_divers: 5,
                                resort: 'Test resort name')
        expect(vacation).to be_valid
      end
    end

    describe 'invvalid' do
      it 'is invalid without a Title' do
        # @details={:title=>[{:error=>:blank}], :price=>[{:error=>:blank}]},
        # @messages={:title=>["can't be blank"], :price=>["can't be blank"]}>
        new_rental_record = Rental.new(price: 4.99)
        new_rental_record.valid?
        expect(new_rental_record.errors[:title]).to include("can't be blank")
      end

      it 'is invalid without a Price' do
        test_rental = Rental.new(title: 'title')
        test_rental.valid?
        expect(test_rental.errors[:price]).to include("can't be blank")
      end
    end
  end

  describe 'Associations' do
    # ... testing go here
  end
end
