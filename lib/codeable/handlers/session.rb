module Codeable
  module Handlers
    module Session
      def create_user
        _user_data = { username: username, password: password } # Codeable::Helpers::Requester.credentials_form
        user_response = {
          id: 46,
          email: "new_user_23@mail.com",
          first_name: "New",
          last_name: "User",
          phone: "918273645",
          token: "8ykE4VZuEJpJip2kXm4TDeQ7"
        } # Codeable::Services::User.create(user_data)
        @token = user_response[:token]
        @username = user_response[:username]
      end
    end
  end
end
