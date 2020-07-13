# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rental, type: :model do
  it 'has a valid factory' do
    expect(build(:rental)).to be_valid
  end

  let(:rental) { create(:rental) }

  describe 'Database columns/indexes' do
    it { expect(rental).to have_db_column(:title).of_type(:string) }
    it { expect(rental).to have_db_column(:price).of_type(:decimal) }
    it { expect(rental).to have_db_column(:description).of_type(:text).with_options(null: true) }
  end

  describe 'Validations' do
    it { expect(rental).to validate_presence_of(:title).with_message(/can't be blank/) }
    it { expect(rental).to validate_presence_of(:price).with_message(/can't be blank/) }
  end

  describe 'rental Model' do
    it 'rental is valid, without description' do
      rental = Rental.new(title: 'title',
                          price: 4.99)
      expect(rental).to be_valid
    end

    it 'Rental is valid, with description' do
      rental = Rental.new(title: 'title',
                          price: 4.99,
                          description: 'description')
      expect(rental).to be_valid
    end

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

  describe 'Associations' do
    # ... testing go here
  end
end
