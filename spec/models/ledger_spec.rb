require 'rails_helper'

describe Ledger do
  let(:ledger) { build(:ledger) }
  subject { ledger }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:page_types) }
    it { is_expected.to have_many(:pages) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:ledger_type) }
  end

  # describe 'callbacks' do
  # end
end
