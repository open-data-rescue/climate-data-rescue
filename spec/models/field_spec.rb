require 'rails_helper'

describe Field do
  let(:field) { build(:field) }
  subject { field }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:field_groups) }
    it { is_expected.to have_many(:field_groups_fields) }
    it { is_expected.to have_many(:field_options) }
    it { is_expected.to have_many(:field_options_fields) }
    it { is_expected.to have_many(:data_entries) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:field_key) }
    it { is_expected.to validate_presence_of(:data_type) }
    it do
      is_expected.to validate_inclusion_of(:data_type).in_array(%w(string integer decimal))
    end
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:check_for_data_entries).before(:destroy) }
  end
end
