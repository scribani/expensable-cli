module Handlers
  module Transactions
    include Helpers::Requester

    def add_transaction(category_id)
      raise StandardError, "Not Found" unless validation_id("categories", category_id)

      transaction_data = transaction_form
      print "loading..."
      transaction_response = Services::Transaction.create(@token, category_id, transaction_data)
      @transactions << transaction_response
    end

    def update_transaction(category_id, transaction_id)
      raise StandardError, "Not Found" unless validation_id("transactions", transaction_id)

      transaction_data = transaction_form
      print "loading..."
      transaction_response = Services::Transaction.update(@token, category_id, transaction_id, transaction_data)
      @transactions << transaction_response
    end

    def delete_transaction(category_id, transaction_id)
      raise StandardError, "Not Found" unless validation_id("transactions", transaction_id)

      print "loading..."
      Services::Transaction.destroy(@token, category_id, transaction_id)
      @transactions.delete_if { |transaction| transaction[:id] == transaction_id }
    end

    def calculate_total(transaction_list)
      return 0 if transaction_list.empty?

      total = 0
      transaction_list.each do |transaction|
        total += transaction[:amount]
      end
      total
    end
  end
end
