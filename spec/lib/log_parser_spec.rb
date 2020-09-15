RSpec.describe LogParser do
  subject(:klass) { described_class }

  it { expect(klass::VERSION).to eq '0.1.0' }
end
