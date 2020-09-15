module LogParser
  class LogItem
    attr_accessor :page, :ip_address

    def initialize(page: nil, ip_address: nil)
      @page = page
      @ip_address = ip_address
    end

    class << self
      def sort_by_page_views(log_items)
        unsorted_hash = {}
        log_items.each do |log_item|
          if unsorted_hash[log_item.page]
            unsorted_hash[log_item.page] << log_item
          else
            unsorted_hash[log_item.page] = [log_item]
          end
        end

        Hash[unsorted_hash.sort_by { |_page, items| items.count }.reverse]
      end
    end
  end
end
