require 'rails_helper'

describe PageTypesFieldGroup do
  let(:page_types_field_group) { build(:page_types_field_group) }
  let(:klass) { PageTypesFieldGroup }
  subject { page_types_field_group }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:page_type) }
    it { is_expected.to belong_to(:field_group) }
  end

  describe 'ActiveModel validations' do
  end

  # describe 'callbacks' do
  # end
  
  it_behaves_like 'a ranked join model'
end
