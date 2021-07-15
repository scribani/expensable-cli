require_relative "validations"

module Helpers
  module Requester
    include Helpers::Validations

    def select_main_menu
      options = %w[login create_user exit]
      gets_with_options options, options
    end

    def select_category_menu
      menu = ["create", "show ID", "update ID", "delete ID\n",
              "\radd-to ID", "toggle", "next", "prev", "logout"]
      options_array = ["create", "show", "update", "delete",
                      "add-to", "toggle", "next", "prev", "logout"]
      gets_with_options menu, options_array
    end

    def select_transaction_menu
      menu = ["add", "update ID", "delete ID\n",
              "\rnext", "prev", "back"]
      options_array = ["add", "update", "delete",
                      "next", "prev", "back"]
      gets_with_options menu, options_array
    end

    def login_user
      email = valid_input_no_empty("Email: ")
      password = valid_input_no_empty("Password: ")
      { email: email, password: password }
    end

    def create_user
      email = valid_email("Email: ")
      password = valid_string("Password: ", length: 6)
      first_name = valid_string("First name: ", required: false)
      last_name = valid_string("Last name: ", required: false)
      phone = valid_phone("Phone: ")
      { email: email, password: password,
        first_name: first_name, last_name: last_name,
        phone: phone }.compact
    end

    def create_and_update_category
      name_transaction = valid_input_no_empty("Name: ")
      transaction_type = valid_transaction_type("Transaction type: ")
      { name: name_transaction, transaction_type: transaction_type }
    end

    def transaction_form
      amount = positive_integer("Amount: ")
      date = valid_date("Date: ")
      notes = valid_string("Notes: ", required: false)
      { amount: amount, date: date, notes: notes }.compact
    end
  end
end
