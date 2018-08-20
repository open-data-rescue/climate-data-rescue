require 'rails_helper'

describe FieldGroupsField do
  let(:field_groups_field) { build(:field_groups_field) }
  let(:klass) { FieldGroupsField }
  subject { field_groups_field }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:field) }
    it { is_expected.to belong_to(:field_group) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:sort_order) }
  end

  # describe 'callbacks' do
  # end
end
