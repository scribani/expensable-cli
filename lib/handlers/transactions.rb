module Codeable
  module Handlers
    module Transactions
      def add_transaction(id)
        transaction_data = Helpers::Requester.transaction_form
        transaction_response = Services::Transaction.create(transaction_data, @token, id)
        found_category = @categories.find(&id_look_up(id))
        found_category[:transactions] << transaction_response
      end

      def update_transaction; end

      def delete_transaction(id); end

      def calculate_total; end
    end
  end
end
