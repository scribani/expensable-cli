module Codeable
  module Handlers
    module Session
      def create_user
        _user_data = { username: username, password: password } # Codeable::Helpers::Requester.create_user_form
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

      def login
        _login_data = { email: "test23@mail.com", password: "123456" } # Codeable::Helpers::Requester.login_form
        login_response = {
          id: 23,
          email: "test23@mail.com",
          first_name: "Test",
          last_name: "User",
          phone: "987654321",
          token: "BF6tKT2if7KZZVs81iY58Dvv"
        } # Codeable::Services::Session.login(login_data)
        @token = login_response[:token]
        @username = login_response[:username]
      end
    end
  end
end
