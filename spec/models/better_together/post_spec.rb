require 'rails_helper'

RSpec.describe BetterTogether::Post, type: :model do
  let(:post) { build(:better_together_post) }
  subject { post }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do

  end

  describe 'ActiveModel validations' do

  end

  describe 'callbacks' do

  end

  it_behaves_like 'a translatable record'
  it_behaves_like 'a friendly slugged record'

  describe '#title' do
    it { is_expected.to respond_to(:title) }
  end

  describe '#content' do
    it { is_expected.to respond_to(:content) }
  end
end
