module Codeable
  module Handlers
    module Categories
      def create_category; end

      def update_category(id); end

      def delete(id); end

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
