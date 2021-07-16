require "json"
require "httparty"

module Services
  class Session
    include HTTParty
    base_uri "https://expensable-api.herokuapp.com/"

    def self.login(login_data)
      options = {
        headers: { "Content-Type": "application/json" },
        body: login_data.to_json
      }
      response = post("/login", options)
      raise HTTParty::ResponseError, response unless response.success?

      JSON.parse(response.body, symbolize_names: true)
    end

    def self.logout(token)
      options = {
        headers: {
          "Content-Type": "application/json",
          Authorization: "Token token=#{token}"
        }
      }
      response = post("/logout", options)
      raise HTTParty::ResponseError, response unless response.success?
    end
  end
end
