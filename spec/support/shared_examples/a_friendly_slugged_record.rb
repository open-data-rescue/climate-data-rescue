
RSpec.shared_examples 'a friendly slugged record' do
  describe 'extends ::FriendlyId' do
    it { expect(described_class).to respond_to(:friendly_id) }
    it { expect(described_class).to respond_to(:slugged) }
  end
end
