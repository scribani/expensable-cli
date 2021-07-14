module Codeable
  module Handlers
    module Categories
      def create_category; end

      def update_category(id); end

      def delete(id); end

      def toggle; end

      def add_to(id)
        _transaction_data = {
          amount: 5,
          date: "2020-11-23",
          notes: "Visit a friend"
        } # Codeable::Helpers::Requester.transaction_form
        transaction_response = {
          id: 2561,
          amount: 5,
          date: "2020-11-23",
          notes: "Visit a friend"
        } # Codeable::Services::Transactions.create(transaction_data, @token)
        found_category = @categories.find { |category| category[:id] == id }
        found_category[:transactions] << transaction_response
      end

      def show(id); end
    end
  end
end
