require_relative "../helpers/requester"
require_relative "../helpers/validations"

module Handlers
  module Categories
    include Helpers::Requester
    include Helpers::Validations

    def id_look_up(id)
      proc { |category| category[:id] == id }
    end

    def create_category
      category_data = create_and_update_category
      print "loading..."
      category_response = Services::Category.create(category_data, @token)
      @categories << category_response
    end

    def update_category(id)
      raise StandardError, "Not Found" unless validation_id("categories", id)

      category_data = create_and_update_category
      print "loading..."
      updated_category = Services::Category.update(category_data, id, @token)
      found_category = @categories.find(&id_look_up(id))
      found_category.merge!(updated_category)
    end

    def delete_category(id)
      raise StandardError, "Not Found" unless validation_id("categories", id)

      print "loading..."
      Services::Category.destroy(id, @token)
      @categories.delete_if(&id_look_up(id))
    end

    def add_to_category(id)
      raise StandardError, "Not Found" unless validation_id("categories", id)

      transaction_data = transaction_form
      print "loading..."
      transaction_response = Services::Transaction.create(@token, id, transaction_data)
      found_category = @categories.find(&id_look_up(id))
      found_category[:transactions] << transaction_response
    end
  end
end
