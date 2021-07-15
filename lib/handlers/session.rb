require_relative "../helpers/requester"
require_relative "../helpers/validations"

module Handlers
  module Session
    include Helpers::Requester

    def create_user
      user_data = create_user
      user_response = Services::User.create(user_data)
      @token = user_response[:token]
    end

    def login
      login_data = login_user
      login_response = Services::Session.login(login_data)
      @token = login_response[:token]
    end
  end
end
