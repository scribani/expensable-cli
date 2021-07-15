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
      email = valid_login("Email: ")
      password = valid_login("Password: ")
      { email: email, password: password }
      # FALTA EL RESPONSE BODY MESSAGE PARA VERIFICAR SI ES EMAIL CORRERCTO O NO
    end

    def create_user
      email = valid_email("Email: ")
      password = valid_string("Password: ", length: 6)
      first_name = valid_string("First name: ", required: false)
      last_name = valid_string("Last name: ", required: false)
      phone = valid_phone("Phone: ")
      { email: email, password: password,
        first_name: first_name, last_name: last_name,
        phone: phone }
    end
  end
end
class Prueba
  include Helpers::Requester
  def initialize
    create_user
  end
end
hola = Prueba.new
p hola
