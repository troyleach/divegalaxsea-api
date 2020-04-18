# frozen_string_literal: true

# for the model migration for price
# add_column :items, :price, :decimal, :precision => 8, :scale => 2

require 'spec_helper'

describe 'Model' do
  it 'has a valid factory' do
    expect(build(:diving)).to be_valid
  end

  # Lazily loaded to ensure it's only used when it's needed
  # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
  let(:diving) { build(:diving) }

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:description) }

    it { expect(diving).to validate_presence_of(:title).with_message(/can't be blank/) }
    it { expect(diving).to validate_presence_of(:price).with_message(/can't be blank/) }

    # Inclusion/acceptance of values
    it { expect(diving).not_to allow_value('abc123').for(:price) }
  end

  describe 'Database columns/indexes' do
    it { expect(diving).to have_db_column(:title).of_type(:string).with_options(null: false) }
    it { expect(diving).to have_db_column(:price).of_type(:decimal).with_options(null: false) }
    it { expect(diving).to have_db_column(:description).of_type(:string).with_options(null: true) }
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
      diving = Diving.new(title: null, price: 4.99)
      diving.valid?
      expect(diving.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a Price' do
      diving = Diving.new(title: 'title', price: null)
      diving.valid?
      expect(diving.errors[:price]).to include("can't be blank")
    end
  end

  describe 'Associations' do
    # ... testing go here
  end
end
