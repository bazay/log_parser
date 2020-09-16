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

      self
    end

    private

    def with_valid_file(&block)
      missing_file_error! unless File.exist?(log_path)

      # NOTE: This may be less performant however uses significantly less memory.
      # The following article provides a good explanation.
      # https://tjay.dev/howto-working-efficiently-with-large-files-in-ruby/
      File.foreach(log_path).each_entry(&block)
    end

    def missing_file_error!
      raise FileNotFoundError, log_path
    end

    def parse_log_line(line)
      page, ip_address = line.split

      LogItem.new(page: page, ip_address: ip_address)
    end
  end
end
