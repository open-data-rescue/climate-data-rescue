
RSpec.shared_examples 'a translatable record' do
  describe 'extends ::Mobility' do
    it { expect(described_class.ancestors).to include(Mobility) }
    it { expect(described_class).to respond_to(:translates) }
  end
end
