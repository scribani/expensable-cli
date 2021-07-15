require "minitest/autorun"
require_relative "./session"
require_relative "./category"
require_relative "./transaction"

class TransactionServiceTest < Minitest::Test
  def setup
    @data = {
      amount: 2600,
      notes: "Salary",
      date: "2021-07-20"
    }
    @data_update = {
      amount: 2100
    }
    @data_login = {
      email: "test24@mail.com",
      password: "123456"
    }
    @token = obtein_token
    @id_category = obtein_id
  end

  def obtein_token
    user_login = Services::Session.login(@data_login)
    user_login[:token]
  end

  def obtein_id
    transactions = Services::Category.list(@token)
    transactions.sample[:id]
  end

  def test_list_call
    response = Services::Transaction.list(@token, @id_category)
    assert_instance_of Array, response
    assert_includes response.sample.keys, :id
    assert_includes response.sample.keys, :amount
    assert_includes response.sample.keys, :date
    assert_includes response.sample.keys, :notes
  end

  def test_create_delete_call
    response = Services::Transaction.create(@token, @id_category, @data)
    assert_instance_of Hash, response
    assert_includes response.keys, :id
    assert_includes response.keys, :amount
    assert_includes response.keys, :date
    assert_includes response.keys, :notes
    id = response[:id]
    show_call id
    update_call id
  end

  def update_call(id)
    response = Services::Transaction.update(@token, @id_category, id, @data_update)
    assert_includes response.keys, :id
    assert_includes response.keys, :amount
    assert_equal response[:amount], @data_update[:amount]
    assert_includes response.keys, :date
    assert_includes response.keys, :notes
    response = Services::Transaction.destroy(@token, @id_category, id)
    assert_nil response
  end

  def show_call(id)
    response = Services::Transaction.show(@token, @id_category, id)
    assert_includes response.keys, :id
    assert_includes response.keys, :amount
    assert_includes response.keys, :date
    assert_includes response.keys, :notes
  end
end
