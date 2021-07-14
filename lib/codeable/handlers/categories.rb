module Codeable
  module Handlers
    module Categories
      def create_category; end

      def update_category(id); end

      def delete(id); end

      def toggle; end

      def add_to(id); end

      def show(_id)
        @transactions = [
          {
            id: 2561,
            amount: 5,
            date: "2020-11-23",
            notes: "Visit a friend"
          },
          {
            id: 2562,
            amount: 120,
            date: "2020-08-23",
            notes: "Buy new matress"
          },
          {
            id: 2563,
            amount: 10,
            date: "2020-12-23",
            notes: "Pick up taxi"
          }
        ] # Codeable::Services::Transactions.index(id, @token)
      end
    end
  end
end
