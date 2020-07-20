# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MiscellaneousPricing, type: :model do
  it 'has a valid factory' do
    expect(build(:miscellaneousPricing)).to be_valid
  end

  let(:miscellaneousPricing) { create(:miscellaneousPricing) }

  describe 'Database columns/indexes' do
    it { expect(miscellaneousPricing).to have_db_column(:title).of_type(:string) }
    it { expect(miscellaneousPricing).to have_db_column(:price).of_type(:decimal) }
    it { expect(miscellaneousPricing).to have_db_column(:description).of_type(:text).with_options(null: true) }
  end

  describe 'Validations' do
    it { expect(miscellaneousPricing).to validate_presence_of(:title).with_message(/can't be blank/) }
    it { expect(miscellaneousPricing).to validate_presence_of(:price).with_message(/can't be blank/) }
  end

  describe 'miscellaneousPricing Model' do
    it 'miscellaneousPricing is valid, without description' do
      miscellaneous_pricing = MiscellaneousPricing.new(title: 'title',
                                                       price: 4.99)
      expect(miscellaneous_pricing).to be_valid
    end

    it 'miscellaneousPricing is valid, with description' do
      miscellaneous_pricing = MiscellaneousPricing.new(title: 'title',
                                                       price: 4.99,
                                                       description: 'description')
      expect(miscellaneous_pricing).to be_valid
    end

    it 'is invalid without a Title' do
      # @details={:title=>[{:error=>:blank}], :price=>[{:error=>:blank}]},
      # @messages={:title=>["can't be blank"], :price=>["can't be blank"]}>
      new_miscellaneous_pricing_record = MiscellaneousPricing.new(price: 4.99)
      new_miscellaneous_pricing_record.valid?
      expect(new_miscellaneous_pricing_record.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a Price' do
      test_miscellaneous_pricing = MiscellaneousPricing.new(title: 'title')
      test_miscellaneous_pricing.valid?
      expect(test_miscellaneous_pricing.errors[:price]).to include("can't be blank")
    end
  end

  describe 'Associations' do
    # ... testing go here
  end
end
