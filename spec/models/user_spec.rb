# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  let(:user) { create(:user) }

  describe 'database columns' do
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
  end

  describe 'Validations' do
    it { expect(user).to validate_presence_of(:first_name).with_message(/can't be blank/) }
    it { expect(user).to validate_presence_of(:last_name).with_message(/can't be blank/) }
    it { should validate_presence_of(:email) }
  end

  describe 'Association' do
    # it { expect(user).to have_many(:reservations)}
    # User will have_many reservations
  end

  describe 'User Model' do
    it 'is invalid without a Email' do
      test_user = User.new(first_name: 'first name', last_name: 'Last name')
      expect(test_user.valid?).to eql(false)
      expect(test_user.errors[:email]).to include("can't be blank")
    end

    it 'Expect Email to be unique' do
      test_user = User.new(first_name: 'first name',
                           last_name: 'Last name',
                           email: user.email)
      expect(test_user.save).to eql(false)
      expect(test_user.errors[:email]).to include('has already been taken')
    end

    it 'Expect valid Email' do
      test_user = User.new(first_name: 'first name',
                           last_name: 'Last name',
                           email: 'this_is_bad_email.com')
      expect(test_user.save).to eql(false)
      expect(test_user.errors[:email]).to include('is invalid')
    end
  end
end
