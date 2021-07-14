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

      def update_category(_id)
        _category_data = {
          name: "New name",
          transaction_type: "income"
        } # Codeable::Helpers::Prompter.category_form
        updated_category = {
          id: 322,
          name: "New name",
          transaction_type: "income",
          transactions: []
        } # Codeable::Services::Categories.update(category_data, id, @token)
        found_category = @categories.find { |category| category[:id] == updated_category[:id] }
        found_category.merge(updated_category)
      end

      def delete(_id)
        # Codeable::Services::Categories.destroy(id, @token)
        @categories.delete_if { |category| category[:id] == id }
      end

      def toggle(_id)
        found_category = @categories.find { |category| category[:id] == id }
        _type = found_category[:transaction_type] == "expense" ? "income" : "expense"
        updated_category = {
          id: 322,
          name: "New name",
          transaction_type: "expense",
          transactions: []
        } # Codeable::Services::Categories.update({ transaction_type: type }, id, @token)
        found_category.merge(updated_category)
      end

      def add_to(id); end

      def show(id); end
    end
  end
end
