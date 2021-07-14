module Codeable
  module Handlers
    module Categories
      def create_category
        category_data = Helpers::Requester.category_form
        category_response = Services::Category.create(category_data, @token)
        @categories << category_response
      end

      def update_category(id)
        _category_data = Helpers::Requester.category_form
        updated_category = Services::Category.update(category_data, id, @token)
        found_category = @categories.find { |category| category[:id] == id }
        found_category.merge(updated_category)
      end

      def delete(id)
        Services::Category.destroy(id, @token)
        @categories.delete_if { |category| category[:id] == id }
      end

      def toggle(id)
        found_category = @categories.find { |category| category[:id] == id }
        type = found_category[:transaction_type] == "expense" ? "income" : "expense"
        updated_category = Services::Category.update({ transaction_type: type }, id, @token)
        found_category.merge(updated_category)
      end

      def add_to(id)
        transaction_data = Helpers::Requester.transaction_form
        transaction_response = Services::Transaction.create(transaction_data, @token, id)
        found_category = @categories.find { |category| category[:id] == id }
        found_category[:transactions] << transaction_response
      end

      def show(_id)
        @transactions = Services::Transaction.list(@token, id)
      end
    end
  end
end
