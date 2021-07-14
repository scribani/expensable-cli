module Codeable
  module Handlers
    module Categories
      def create_category; end

      def update_category(id); end

      def delete(_id)
        # Codeable::Services::Categories.destroy(id, @token)
        @categories.delete_if { |category| category[:id] == id }
      end

      def toggle; end

      def add_to(id); end

      def show(id); end
    end
  end
end
