require 'log_parser/parser'

RSpec.describe LogParser::Parser do
  subject(:parser) { described_class.new log_file_path }

  let(:log_file_path) { file_fixture(filename) }
  let(:filename) { 'test_webserver_log.log' }

  describe '#parse' do
    subject(:parse) { parser.parse }

    let(:expected_log_items) do
      [
        { page: '/help_page/1', ip_address: '126.318.035.038'},
        { page: '/contact', ip_address: '184.123.665.067' },
        { page: '/home', ip_address: '184.123.665.067' },
        { page: '/about/2', ip_address: '444.701.448.104' },
        { page: '/help_page/1', ip_address: '929.398.951.889' },
        { page: '/index', ip_address: '444.701.448.104' },
        { page: '/help_page/1', ip_address: '722.247.931.582' },
        { page: '/about', ip_address: '061.945.150.735' },
        { page: '/help_page/1', ip_address: '646.865.545.408' },
        { page: '/home', ip_address: '235.313.352.950' }
      ]
    end

    it { expect { parse }.to change { parser.log_items }.from([]).to(expected_log_items) }

    context "when file doesn't exist" do
      let(:filename) { 'missing.log' }

      it { expect { parse }.to raise_error(LogParser::FileNotFoundError) }
    end
  end
end
