require 'rails_helper'

describe FieldGroup do
  let(:field_group) { build(:field_group) }
  subject { field_group }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:fields) }
    it { is_expected.to have_many(:field_groups_fields) }
    it { is_expected.to have_many(:annotations) }
    it { is_expected.to have_many(:page_types) }
    it { is_expected.to have_many(:page_types_field_groups) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:colour_class) }
    it do
      is_expected.to validate_inclusion_of(:colour_class).in_array(%w(red-group pink-group purple-group blue-group cyan-group green-group yellow-group orange-group))
    end
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:help) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:check_for_annotations).before(:destroy) }
  end

  describe '#presentation_name' do
    context 'when display_name set' do
      it 'returns the display name' do
        expect(subject.presentation_name).to eq(subject.display_name)
      end
    end

    context 'when display_name not set' do
      it 'returns the name' do
        subject.display_name = nil
        expect(subject.presentation_name).to eq(subject.name)
      end
    end
  end
end
