require 'rails_helper'

describe FieldOption do
  let(:field_option) { build(:field_option) }
  let(:klass) { FieldOption }
  subject { field_option }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:fields) }
    it { is_expected.to have_many(:field_options_fields) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:help) }
  end

  # describe 'callbacks' do
  # end
  
  describe 'paperclip attachment' do

  end
  
  describe '.only_defaults' do
    it { expect(klass).to respond_to(:only_defaults) }
  end
end
