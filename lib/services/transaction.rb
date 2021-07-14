require "json"
require "httparty"

module Services
  class Transaction
    include HTTParty
    base_uri "https://expensable-api.herokuapp.com/categories"

    def self.list(token, id)
      request(token, "get", id)
    end

    def self.create(transaction_data, token, id)
      request(token, "post", id, transaction_data)
    end

    def self.show(token, id, transaction_id)
      request(token, "get", id, nil, transaction_id)
    end

    def self.update(transaction_data, id, token, transaction_id)
      request(token, "patch", id, transaction_data, transaction_id)
    end

    def self.destroy(id, token, transaction_id)
      request(token, "delete", id, nil, transaction_id)
    end

    def self.request(token, http_method, id, data = nil, transaction_id = nil)
      options = {
        headers: {
          "Content-Type": "application/json",
          Authorization: "Token token=#{token}"
        },
        body: data.to_json
      }
      response = method(http_method.to_sym).call("/#{id}/transactions/#{transaction_id}", options)
      raise HTTParty::ResponseError, response unless response.success?

      JSON.parse(response.body, symbolize_names: true) if response.body
    end
  end
end
