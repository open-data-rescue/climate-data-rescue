require 'rails_helper'

describe User do
  let(:user) { build(:user) }
  subject { user }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:transcriptions) }
    it { is_expected.to have_many(:annotations) }
    it { is_expected.to have_many(:data_entries) }
    it { is_expected.to have_many(:pages) }
  end

  describe 'ActiveModel validations' do
  end

  describe 'callbacks' do
  end
  
  describe 'paperclip attachment' do
    it { is_expected.to have_attached_file(:avatar) }
    it { is_expected.to validate_attachment_content_type(:avatar).
                  allowing("image/jpg","image/jpeg", "image/png") }
    it { is_expected.to validate_attachment_size(:avatar).
                less_than(2.megabytes) }
  end

  describe '#name' do
    context 'when display_name set' do
      it 'returns the display name' do
        subject.display_name = 'joe'
        expect(subject.name).to eq(subject.display_name)
      end
    end

    context 'when display_name not set' do
      it 'returns the name' do
        subject.display_name = nil
        expect(subject.name).to eq(subject.email)
      end
    end
  end
end
