require 'rails_helper'

describe FieldOptionsField do
  let(:field_options_field) { build(:field_options_field) }
  let(:klass) { FieldOptionsField }
  subject { field_options_field }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:field) }
    it { is_expected.to belong_to(:field_option) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:sort_order) }
  end

  # describe 'callbacks' do
  # end
end
