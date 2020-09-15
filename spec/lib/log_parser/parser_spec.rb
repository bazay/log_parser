require 'log_parser/parser'
require 'log_parser/log_item'

RSpec.describe LogParser::Parser do
  subject(:parser) { described_class.new log_file_path }

  let(:log_file_path) { file_fixture(filename) }
  let(:filename) { 'test_webserver_log.log' }

  describe '#parse' do
    subject(:parse) { parser.parse }

    it { expect { parse }.to change { parser.log_items.count }.from(0).to(10) }

    context "when file doesn't exist" do
      let(:filename) { 'missing.log' }

      it { expect { parse }.to raise_error(LogParser::FileNotFoundError) }
    end
  end

  describe '#log_items' do
    subject { parser.log_items }

    it { is_expected.to eql [] }

    context 'when #parse is performed' do
      before { parser.parse }

      it { is_expected.to all(be_a(LogParser::LogItem)) }

      context 'when inspecting first log item attributes' do
        subject { parser.log_items.first }

        its(:page) { is_expected.to eql '/help_page/1' }
        its(:ip_address) { is_expected.to eql '126.318.035.038' }
      end
    end
  end
end
