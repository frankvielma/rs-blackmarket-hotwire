# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  first_name             :string           default("")
#  last_name              :string           default("")
#  username               :string           default("")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:encrypted_password) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:favorite_products).dependent(:destroy) }
    it { is_expected.to have_many(:shopping_carts).dependent(:destroy) }
  end

  describe '#full_name' do
    context 'with first and last name' do
      let(:user) { described_class.create(first_name: 'John', last_name: 'Doe') }

      it 'returns the full name' do
        expect(user.full_name).to eq('John Doe')
      end
    end

    context 'with only first name' do
      let(:user) { described_class.create(first_name: 'John') }

      it 'returns the first name' do
        expect(user.full_name).to eq('John')
      end
    end

    context 'with no name' do
      let(:user) { described_class.create }

      it 'returns an empty string' do
        expect(user.full_name).to eq('')
      end
    end
  end
end
