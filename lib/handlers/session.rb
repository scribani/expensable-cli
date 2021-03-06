require_relative "../helpers/requester"
require_relative "../helpers/validations"

module Handlers
  module Session
    include Helpers::Requester

    def create_new_user
      user_data = create_user
      print "loading..."
      user_response = Services::User.create(user_data)
      @token = user_response[:token]
    end

    def login
      login_data = login_user
      print "loading..."
      login_response = Services::Session.login(login_data)
      @token = login_response[:token]
    end
  end
end
