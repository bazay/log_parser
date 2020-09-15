require 'log_parser/log_item'

RSpec.describe LogParser::LogItem do
  subject(:log_item) { described_class.new(attributes) }

  let(:attributes) { { page: page, ip_address: ip_address } }
  let(:page) { '/home' }
  let(:ip_address) { '127.0.0.1' }

  its(:page) { is_expected.to eq page }
  its(:ip_address) { is_expected.to eq ip_address }

  describe '.sort_by_page_views' do
    subject(:sort_by_page_views) { described_class.sort_by_page_views(log_items) }

    let(:log_items) { [first_log_item, second_log_item, third_log_item] }
    let(:first_log_item) { LogParser::LogItem.new(page: '/contact', ip_address: '127.0.0.1') }
    let(:second_log_item) { LogParser::LogItem.new(page: '/home', ip_address: '192.168.1.1') }
    let(:third_log_item) { LogParser::LogItem.new(page: '/home', ip_address: '127.0.0.1') }
    let(:expected_result) do
      {
        '/home' => [second_log_item, third_log_item],
        '/contact' => [first_log_item]
      }
    end

    it { is_expected.to eql expected_result }
  end
end
