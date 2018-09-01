require 'rails_helper'

describe Annotation do
  let(:annotation) { build(:annotation) }
  subject { annotation }
  let(:klass) { Annotation }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:field_group) }
    it { is_expected.to belong_to(:page) }
    # it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:transcription).touch(true) }
    it { is_expected.to have_many(:data_entries).dependent(:destroy) }
  end

  describe 'ActiveModel validations' do
    it { should validate_presence_of(:date_time_id) }
    it { should validate_presence_of(:observation_date) }
  end

  describe 'callbacks' do
  end

  describe '.order_by_date' do
    it { expect(klass).to respond_to(:order_by_date) }
  end

end
