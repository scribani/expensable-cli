require "httparty"
require "json"
require "minitest/autorun"
require_relative "./session"
require_relative "../io_test_helpers"
require_relative "../helpers/requester"
require_relative "../services/session"
require_relative "../services/user"

class CategoryServiceTest < Minitest::Test
  include Handlers::Session
  include IoTestHelpers
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def setup
    @user_data = { email: "test23@mail.com", password: "123456" }
    @options = {
      headers: { "Content-Type": "application/json" },
      body: @user_data.to_json
    }
    @token = self.class.obtain_token(@options)
  end

  def self.obtain_token(options)
    response = post("/login", options)
    response.parsed_response["token"]
  end

  def clean_user_after_test
    self.class.delete("/profile", { headers: { Authorization: "Token token=#{@token}" } })
  end

  def test_create_user_correctly_returns_email_from_server_response
    inputs = ["new_user_23@mail.com", "123456"]
    email = ""

    capture_io do
      simulate_stdin(*inputs) do
        email = create_user
      end
    end
    clean_user_after_test

    assert_equal "new_user_23@mail.com", email
  end
end
