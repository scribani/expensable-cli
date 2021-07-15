require "httparty"
require "minitest/autorun"
require_relative "./categories"
require_relative "../io_test_helpers"
require_relative "../helpers/requester"
require_relative "../services/category"
require_relative "../services/transaction"

class CategoriesHandlersTest < Minitest::Test
  include Handlers::Categories
  include IoTestHelpers
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def setup
    @token = nil
    @categories = []
  end

  def clean_category_after_test(id)
    self.class.delete("/categories/#{id}", headers: { Authorization: "Token token=#{@token}" })
  end

  def test_create_category_correctly_adds_new_category_to_list
    inputs = ["Test Transaction", "income"]

    capture_io do
      simulate_stdin(*inputs) do
        create_category
      end
    end
    id = @categories.last[:id]
    clean_category_after_test(id)

    assert_instance_of Hash, @categories.last
    assert_includes @categories.last.keys, :id
    assert_includes @categories.last.keys, :name
    assert_includes @categories.last.keys, :transaction_type
    assert_includes @categories.last.keys, :transactions
  end

  def test_update_category_correctly_updates_category
    inputs = ["Test Transaction", "income", "Updated name", "expense"]

    id = nil
    capture_io do
      simulate_stdin(*inputs) do
        create_category
        id = @categories.last[:id]
        update_category(id)
      end
    end
    clean_category_after_test(id)

    assert_equal "Updated name", @categories.last[:name]
    assert_equal "expense", @categories.last[:transaction_type]
  end
end
