module Codeable
  module Handlers
    module Categories
      def create_category
        _category_data = {
          name: "Salario",
          transaction_type: "expense"
        } # Codeable::Helpers::Requester.create_category_form
        category_response = {
          id: 322,
          name: "Test category",
          transaction_type: "income",
          transactions: []
        } # Codeable::Services::Categories.create(category_data, @token)
        @categories << category_response
      end

      def update_category(id); end

      def delete(id); end

      def toggle; end

      def add_to(id); end

      def show(id); end
    end
  end
end
