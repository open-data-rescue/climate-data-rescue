require 'rails_helper'

describe StaticPage do
  let(:static_page) { build(:static_page) }
  subject { static_page }
  let(:klass) { StaticPage }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_uniqueness_of(:foreign_link).allow_blank }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:update_positions_and_slug).before(:save) }
  end

  describe '#is_external?' do
    context 'when foreign_link is set' do
      it do
        static_page.foreign_link = Faker::Internet.url
        expect(static_page.is_external?).to be_truthy
      end
    end
    context 'when foreign_link is not set' do
      it do
        static_page.foreign_link = nil
        expect(static_page.is_external?).to be_falsy
      end
    end
  end

  describe '#link' do
    context 'when foreign_link is set' do
      it do
        static_page.foreign_link = Faker::Internet.url
        expect(static_page.link).to eq(static_page.foreign_link)
      end
    end
    context 'when foreign_link is not set' do
      it do
        static_page.foreign_link = nil
        expect(static_page.link).to eq("/#{I18n.locale}#{static_page.slug}")
      end
    end
  end
end
