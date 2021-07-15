module Helpers
  module Filters
    def self.filter_by_type(list, type = "expense")
      list.select { |item| item[:transaction_type] == type }
    end

    def self.filter_by_date(list, date)
      regex = "(#{date[0..-4]}-)(\\d{2})"
      select_transaction = []
      list.each do |category|
        category[:transactions].each do |transaction|
          select_transaction << transaction if transaction[:date].match?(regex)
        end
      end
      select_transaction
    end
  end
end
