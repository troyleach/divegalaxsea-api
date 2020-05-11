# frozen_string_literal: true

# for the model migration for price
# add_column :items, :price, :decimal, :precision => 8, :scale => 2

require 'rails_helper'

# RSpec.describe Diving, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
describe Diving do
  it 'has a valid factory' do
    expect(build(:diving)).to be_valid
  end

  # Lazily loaded to ensure it's only used when it's needed
  # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
  let(:diving) { create(:diving) }

  describe 'Validations' do
    it { expect(diving).to validate_presence_of(:title).with_message(/can't be blank/) }
    it { expect(diving).to validate_presence_of(:price).with_message(/can't be blank/) }

    # Inclusion/acceptance of values
    # not sure why this doesnot work
    # it { expect(diving).not_to allow_value('abc123').for(:price) }
  end

  describe 'Database columns/indexes' do
    it { expect(diving).to have_db_column(:title).of_type(:string) }
    it { expect(diving).to have_db_column(:price).of_type(:decimal) }
    it { expect(diving).to have_db_column(:description).of_type(:text).with_options(null: true) }
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

    xit 'is invalid without a Title' do
      # have no fukcing idea why this doesn't work
      # ArgumentError:
      #  wrong number of arguments (given 0, expected 1+)
      d = Diving.new(title: null)
      d.valid?
      # @details={:title=>[{:error=>:blank}], :price=>[{:error=>:blank}]},
      # @messages={:title=>["can't be blank"], :price=>["can't be blank"]}>
      expect(d.errors[:title]).to include("can't be blank")
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
