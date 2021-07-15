require_relative "validations"

module Helpers
  module Requester
    include Helpers::Validations

    def select_main_menu
      gets_with_options %w[login create_user exit]
    end

    def select_category_menu
      options_array = ["create", "show ID", "update ID", "delete ID\n",
                       "\radd-to ID", "toggle", "next", "prev", "logout"]
      gets_with_options options_array
    end

    def select_transaction_menu
      options_array = ["add", "update ID", "delete ID\n",
                       "\rnext", "prev", "back"]
      gets_with_options options_array
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
