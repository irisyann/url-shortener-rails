require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) } # using FactoryBot to create a user for testing

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid email' do
      user.email = 'not_an_email'
      expect(user).not_to be_valid
    end

    it 'is not valid with a password less than 6 characters' do
      user.password = '12345'
      expect(user).not_to be_valid
    end

    it 'is not valid without a password confirmation' do
      user.password_confirmation = nil
      expect(user).not_to be_valid
    end
  end

#   describe 'associations' do
#     it { should have_many(:target_url).dependent(:destroy) }
#   end
end

