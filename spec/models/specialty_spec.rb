# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Specialty, type: :model do
  it 'has a valid factory' do
    expect(build(:specialty)).to be_valid
  end

  let(:specialty) { create(:specialty) }

  describe 'Database columns/indexes' do
    it { expect(specialty).to have_db_column(:title).of_type(:string) }
    it { expect(specialty).to have_db_column(:price).of_type(:decimal) }
    it { expect(specialty).to have_db_column(:description).of_type(:text).with_options(null: true) }
  end

  describe 'Validations' do
    it { expect(specialty).to validate_presence_of(:title).with_message(/can't be blank/) }
    it { expect(specialty).to validate_presence_of(:price).with_message(/can't be blank/) }
  end

  describe 'Specialty Model' do
    it 'rental is valid, without description' do
      specialty = Specialty.new(title: 'title',
                                price: 4.99)
      expect(specialty).to be_valid
    end

    it 'Specialty is valid, with description' do
      specialty = Specialty.new(title: 'title',
                                price: 4.99,
                                description: 'description')
      expect(specialty).to be_valid
    end

    it 'is invalid without a Title' do
      # @details={:title=>[{:error=>:blank}], :price=>[{:error=>:blank}]},
      # @messages={:title=>["can't be blank"], :price=>["can't be blank"]}>
      new_specialty_record = Specialty.new(price: 4.99)
      new_specialty_record.valid?
      expect(new_specialty_record.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a Price' do
      test_specialty = Specialty.new(title: 'title')
      test_specialty.valid?
      expect(test_specialty.errors[:price]).to include("can't be blank")
    end
  end

  describe 'Associations' do
    # ... testing go here
  end
end
