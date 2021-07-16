module Helpers
  module Filters
    def filter_by_type(list, type)
      list.select { |item| item[:transaction_type] == type }
    end

    def filter_by_date(list, date)
      regex = "(#{date[0..-4]}-)(\\d{2})"
      select_transactions = []
      list.each do |transaction|
        select_transactions << transaction if transaction[:date].match?(regex)
      end
      select_transactions
    end
  end
end
