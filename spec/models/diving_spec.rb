# frozen_string_literal: true

require 'rails_helper'

# describe Diving do
RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:diving)).to be_valid
  end

  let(:diving) { create(:diving) }

  describe 'Database columns/indexes' do
    it { expect(diving).to have_db_column(:title).of_type(:string) }
    it { expect(diving).to have_db_column(:price).of_type(:decimal) }
    it { expect(diving).to have_db_column(:description).of_type(:text).with_options(null: true) }
  end

  describe 'Validations' do
    it { expect(diving).to validate_presence_of(:title).with_message(/can't be blank/) }
    it { expect(diving).to validate_presence_of(:price).with_message(/can't be blank/) }
  end

  describe 'Diving Model' do
    it 'Diving is valid, without description' do
      diving = Diving.new(title: 'title',
                          price: 4.99)
      expect(diving).to be_valid
    end

    it 'Diving is valid, with description' do
      diving = Diving.new(title: 'title',
                          price: 4.99,
                          description: 'description')
      expect(diving).to be_valid
    end

    it 'is invalid without a Title' do
      # @details={:title=>[{:error=>:blank}], :price=>[{:error=>:blank}]},
      # @messages={:title=>["can't be blank"], :price=>["can't be blank"]}>
      new_diving_record = Diving.new(price: 4.99)
      new_diving_record.valid?
      expect(new_diving_record.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a Price' do
      test_diving = Diving.new(title: 'title')
      test_diving.valid?
      expect(test_diving.errors[:price]).to include("can't be blank")
    end
  end

  describe 'Associations' do
    # ... testing go here
  end
end
