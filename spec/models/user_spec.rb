# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  describe 'database columns' do
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
  end

  describe 'Validations' do
    it { expect(user).to validate_presence_of(:first_name).with_message(/can't be blank/) }
    it { expect(user).to validate_presence_of(:last_name).with_message(/can't be blank/) }
    it { should validate_presence_of(:email) }
    # FIXME: need to validate valid email
    # Should write a test for the email format
  end

  describe 'Association' do
    # it { expect(user).to have_many(:reservations)}
    # User will have_many reservations
  end
end
