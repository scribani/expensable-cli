module Codeable
  module Handlers
    module Transactions
      def append_to_transactions(transaction_response)
        found_category = @categories.find { |category| category[:id] == id }
        found_category[:transactions] << transaction_response
      end

      def add_transaction(category_id)
        transaction_data = Helpers::Requester.transaction_form
        transaction_response = Services::Transaction.create(transaction_data, @token, category_id)
        append_to_transactions(transaction_response)
      end

      def update_transaction(category_id, transaction_id)
        transaction_data = Helpers::Requester.transaction_form
        transaction_response = Services::Transaction.update(transaction_data, category_id, @token, transaction_id)
        append_to_transactions(transaction_response)
      end

      def delete_transaction(id); end

      def calculate_total; end
    end
  end
end
