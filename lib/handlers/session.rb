module Handlers
  module Session
    def create_user
      user_data = Helpers::Requester.login_user
      user_response = Services::User.create(user_data)
      @token = user_response[:token]
      @email = user_response[:email]
    end

    def login
      login_data = Helpers::Requester.login_user
      login_response = Services::Session.login(login_data)
      @token = login_response[:token]
      @email = login_response[:email]
    end
  end
end
