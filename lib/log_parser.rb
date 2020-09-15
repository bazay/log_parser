require 'log_parser/version'
require 'log_parser/parser'
require 'log_parser/log_item'

module LogParser
  def self.root
    File.expand_path '../..', __FILE__
  end

  class FileNotFoundError < StandardError
    def initialize(file)
      msg = "File count not be found: '#{file}'"
      super(msg)
    end
  end
end
