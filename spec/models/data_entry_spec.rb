require 'rails_helper'

describe DataEntry do
  let(:data_entry) { build(:data_entry) }
  subject { data_entry }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:field) }
    it { is_expected.to belong_to(:page) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:annotation).touch(true) }
  end

  describe 'ActiveModel validations' do
    # it { is_expected.to validate_uniqueness_of(:field_id).scoped_to(:annotation_id) }
    # it { is_expected.to validate_presence_of(:data_type) }
    # it { is_expected.to validate_presence_of(:value) }
  end

  describe 'callbacks' do
  end
end
