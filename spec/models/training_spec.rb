# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Training, type: :model do
  it 'has a valid factory' do
    expect(build(:training)).to be_valid
  end

  let(:training) { create(:training) }

  describe 'Database columns/indexes' do
    it { expect(training).to have_db_column(:title).of_type(:string) }
    it { expect(training).to have_db_column(:price).of_type(:decimal) }
    it { expect(training).to have_db_column(:description).of_type(:text).with_options(null: true) }
  end

  describe 'Validations' do
    it { expect(training).to validate_presence_of(:title).with_message(/can't be blank/) }
    it { expect(training).to validate_presence_of(:price).with_message(/can't be blank/) }
  end

  describe 'Training Model' do
    it 'Training is valid, without description' do
      training = Training.new(title: 'title',
                              price: 4.99)
      expect(training).to be_valid
    end

    it 'Training is valid, with description' do
      training = Training.new(title: 'title',
                              price: 4.99,
                              description: 'description')
      expect(training).to be_valid
    end

    it 'is invalid without a Title' do
      # @details={:title=>[{:error=>:blank}], :price=>[{:error=>:blank}]},
      # @messages={:title=>["can't be blank"], :price=>["can't be blank"]}>
      new_training_record = Training.new(price: 4.99)
      new_training_record.valid?
      expect(new_training_record.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a Price' do
      test_training = Training.new(title: 'title')
      test_training.valid?
      expect(test_training.errors[:price]).to include("can't be blank")
    end
  end

  describe 'Associations' do
    # ... testing go here
  end
end
