module Codeable
  module Handlers
    module Session
      def create_user
        user_data = Codeable::Helpers::Requester.login_user
        user_response = Codeable::Services::User.create(user_data)
        @token = user_response[:token]
        @username = user_response[:username]
      end

      def login
        login_data = Codeable::Helpers::Requester.login_user
        login_response = Codeable::Services::Session.login(login_data)
        @token = login_response[:token]
        @username = login_response[:username]
      end
    end
  end
end
