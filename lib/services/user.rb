require "json"
require "httparty"

module Services
  class User
    include HTTParty
    base_uri "https://expensable-api.herokuapp.com/"

    def self.create(user_data)
      options = {
        headers: { "Content-Type": "application/json" },
        body: user_data.to_json
      }
      response = post("/signup", options)
      raise HTTParty::ResponseError, response unless response.success?

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
