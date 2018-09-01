require 'rails_helper'

describe Transcription do
  let(:transcription) { build(:transcription) }
  subject { transcription }
  let(:klass) { Transcription }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:field_groups) }
    it { is_expected.to have_many(:field_groups_fields) }
    it { is_expected.to have_many(:fields) }
    it { is_expected.to have_many(:data_entries) }
    it { is_expected.to have_many(:annotations).dependent(:destroy) }
    it { is_expected.to have_one(:page_type) }
  end

  describe 'ActiveModel validations' do
    it { should validate_uniqueness_of(:page_id).scoped_to(:user_id) }
  end

  describe 'callbacks' do
  end

  describe '#num_rows_started' do
    it { is_expected.to respond_to(:num_rows_started) }
  end

  describe '#num_rows_expected' do
    it { is_expected.to respond_to(:num_rows_expected) }
  end

  describe '#num_data_entries' do
    it { is_expected.to respond_to(:num_data_entries) }
  end

  describe '#num_data_entries_expected' do
    it { is_expected.to respond_to(:num_data_entries_expected) }
  end

  describe '#percent_complete' do
    it { is_expected.to respond_to(:percent_complete) }
  end
end
