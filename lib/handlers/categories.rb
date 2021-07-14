module Codeable
  module Handlers
    module Categories
      def id_look_up(id)
        proc { |category| category[:id] == id }
      end

      def create_category
        category_data = Helpers::Requester.category_form
        category_response = Services::Category.create(category_data, @token)
        @categories << category_response
      end

      def update_category(id)
        category_data = Helpers::Requester.category_form
        updated_category = Services::Category.update(category_data, id, @token)
        found_category = @categories.find(&id_look_up(id))
        found_category.merge(updated_category)
      end

      def delete_category(id)
        Services::Category.destroy(id, @token)
        @categories.delete_if(&id_look_up(id))
      end

      def toggle_category(id)
        found_category = @categories.find(&id_look_up(id))
        type = found_category[:transaction_type] == "expense" ? "income" : "expense"
        updated_category = Services::Category.update({ transaction_type: type }, id, @token)
        found_category.merge(updated_category)
      end

      def add_to_category(id)
        transaction_data = Helpers::Requester.transaction_form
        transaction_response = Services::Transaction.create(transaction_data, @token, id)
        found_category = @categories.find(&id_look_up(id))
        found_category[:transactions] << transaction_response
      end

      def show_category(id)
        @transactions = Services::Transaction.list(@token, id)
      end
    end
  end
end
