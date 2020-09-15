require 'log_parser/log_item'

module LogParser
  class Parser
    attr_reader :log_path, :log_items

    def initialize(log_path)
      @log_path = log_path
      @log_items = []
    end

    def parse
      with_valid_file do |line|
        @log_items << parse_log_line(line)
      end
    end

    private

    def with_valid_file
      missing_file_error! unless File.exist?(log_path)

      File.open(log_path) do |file|
        file.each_line do |line|
          yield(line)
        end
      end
    end

    def missing_file_error!
      raise FileNotFoundError.new(log_path)
    end

    def parse_log_line(line)
      page, ip_address = line.split

      LogItem.new(page: page, ip_address: ip_address)
    end
  end
end
