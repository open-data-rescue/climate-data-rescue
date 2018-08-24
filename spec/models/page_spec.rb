require 'rails_helper'

describe Page do
  let(:page) { build(:page) }
  subject { page }
  let(:klass) { Page }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
  end

  describe 'ActiveModel validations' do
  end

  describe 'callbacks' do
    it { is_expected.to callback(:extract_upload_dimensions).before(:save) }
    it { is_expected.to callback(:parse_filename).after(:create) }
    it { is_expected.to callback(:check_for_delete).before(:destroy) }
  end

  describe 'paperclip attachment' do
    it { is_expected.to have_attached_file(:image) }
    it { is_expected.to validate_attachment_content_type(:image).
                  allowing("image/jpg","image/jpeg", "image/png") }
  end

  describe '#has_metadata?' do
    it { is_expected.to respond_to(:has_metadata?) }

    context 'when it has page_days' do
      it 'returns true' do
        page.page_days.new
        expect(page.has_metadata?).to be_truthy
      end
    end

    context 'when it does not have a page_day' do
      it 'returns true' do
        page.page_days = []
        expect(page.has_metadata?).to be_falsy
      end
    end
  end
end
