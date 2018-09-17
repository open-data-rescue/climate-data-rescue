
RSpec.shared_examples 'a ranked join model' do
  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:sort_order).on(:update) }
  end
end
