require 'rails_helper'

describe PageType do
  let(:page_type) { build(:page_type) }
  subject { page_type }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:fields) }
    it { is_expected.to have_many(:field_groups) }
    it { is_expected.to have_many(:annotations) }
    it { is_expected.to have_many(:pages) }
    it { is_expected.to have_many(:transcriptions) }
    it { is_expected.to have_many(:page_types_field_groups) }

    it { is_expected.to belong_to(:ledger) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'callbacks' do
  end
end
