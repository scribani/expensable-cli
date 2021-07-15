require "minitest/autorun"
require_relative "./category"
require_relative "./session"

class CategoryServiceTest < Minitest::Test
  def setup
    @data = {
      name: "salud123",
      transaction_type: "expense"
    }
    @data_update = {
      name: "salud y medicina"
    }
    @data_login = {
      email: "test24@mail.com",
      password: "123456"
    }
    @token = obtein_token
  end

  def obtein_token
    user_login = Services::Session.login(@data_login)
    user_login[:token]
  end

  def test_list_call
    response = Services::Category.list(@token)
    assert_instance_of Array, response
    assert_includes response.sample.keys, :id
    assert_includes response.sample.keys, :name
    assert_includes response.sample.keys, :transaction_type
    assert_includes response.sample.keys, :transactions
  end

  def test_create_delete_call
    response = Services::Category.create(@data, @token)
    assert_instance_of Hash, response
    assert_includes response.keys, :id
    assert_includes response.keys, :name
    assert_includes response.keys, :transaction_type
    assert_includes response.keys, :transactions
    id = response[:id]
    show_call id
    update_call id
  end

  def update_call(id)
    response = Services::Category.update(@data_update, id, @token)
    assert_includes response.keys, :id
    assert_includes response.keys, :name
    assert_equal response[:name], @data_update[:name]
    assert_includes response.keys, :transaction_type
    assert_includes response.keys, :transactions
    response = Services::Category.destroy(id, @token)
    assert_nil response
  end

  def show_call(id)
    response = Services::Category.show( id, @token)
    assert_includes response.keys, :id
    assert_includes response.keys, :name
    assert_includes response.keys, :transaction_type
    assert_includes response.keys, :transactions
  end
end
