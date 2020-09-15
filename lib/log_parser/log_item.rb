module LogParser
  class LogItem
    attr_accessor :page, :ip_address

    def initialize(page: nil, ip_address: nil)
      @page = page
      @ip_address = ip_address
    end

    def ==(other)
      page == other.page && ip_address == other.ip_address
    end

    class << self
      def sort_by_page_views(log_items)
        build_sorted_hash(log_items)
      end

      def sort_by_unique_views(log_items)
        build_sorted_hash(log_items, unique: true)
      end

      private

      def build_sorted_hash(log_items, unique: false)
        unsorted_hash = {}
        log_items.each do |log_item|
          if unsorted_hash[log_item.page]
            unsorted_hash[log_item.page] << log_item unless unique && unsorted_hash[log_item.page].include?(log_item)
          else
            unsorted_hash[log_item.page] = [log_item]
          end
        end

        Hash[unsorted_hash.sort_by { |_page, items| items.count }.reverse]
      end
    end
  end
end
