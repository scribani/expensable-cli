require "json"
require "httparty"

module Services
  class Category
    include HTTParty
    base_uri "https://expensable-api.herokuapp.com/categories"

    def self.list(token)
      request(token, "get")
    end

    def self.show(id, token)
      request(token, "get", id)
    end
    def self.create(category_data, token)
      request(token, "post", nil, category_data)
    end

    def self.update(category_data, id, token)
      request(token, "patch", id, category_data)
    end

    def self.destroy(id, token)
      request(token, "delete", id)
    end

    def self.request(token, http_method, id = nil, data = nil)
      options = {
        headers: {
          "Content-Type": "application/json",
          Authorization: "Token token=#{token}"
        },
        body: data.to_json
      }
      response = method(http_method.to_sym).call("/#{id}", options)
      raise HTTParty::ResponseError, response unless response.success?

      JSON.parse(response.body, symbolize_names: true) if response.body
    end
  end
end
