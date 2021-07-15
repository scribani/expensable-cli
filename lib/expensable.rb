require "json"
require "terminal-table"
require_relative "./handlers/session"
require_relative "./handlers/transactions"
require_relative "./handlers/categories"
require_relative "./helpers/presenter"
require_relative "./helpers/requester"
require_relative "./services/session"
require_relative "./services/user"
require_relative "./services/category"
require_relative "./services/transaction"

class Expensable
  include Helpers::Presenter
  include Helpers::Requester
  include Handlers::Session
  include Handlers::Transactions
  include Handlers::Categories

  def initialize
    @token = nil
    @categories = []
    @transactions = []
  end

  def start
    action, _id = select_main_menu
    until action == "exit"
      begin
        case action
        when "login" then login
        when "create_user" then create_new_user
        end
      rescue HTTParty::ResponseError => e
        @token = nil
        puts JSON.parse(e.message)["errors"].first
      end
      category_page if @token
      action, _id = select_main_menu
    end
  end

  def print_updated_table
    @categories.map do |category|
      category[:total] = calculate_total(category[:transactions])
    end
    print_table(@categories)
  end

  def category_page
    @categories = Services::Category.list(@token)
    print_updated_table
    action, id = select_category_menu
    until action == "logout"
      begin
        case action
        when "create" then create_category
        when "show" then transaction_page(id)
        when "update" then update_category(id)
        when "delete" then delete_category(id)
        when "add-to" then add_to_category(id)
        when "toggle" then puts "toggle" # HARDCODE!!!
        when "next" then puts "next_month" # HARDCODE!!!
        when "prev" then puts "prev_month" # HARDCODE!!!
        end
      rescue HTTParty::ResponseError => e
        puts JSON.parse(e.message)["errors"].first
      end
      print_updated_table
      action, id = select_category_menu
    end
  end

  def transaction_page(category_id)
    print "loading..."
    @transactions = Services::Transaction.list(@token, category_id)
    selected_category = @categories.find { |category| category[:id] == category_id }
    category_name = selected_category[:name]
    print_transactions_table(category_name, @transactions)
    action, transaction_id = select_transaction_menu
    until action == "back"
      begin
        case action
        when "add" then add_transaction(category_id)
        when "update" then update_transaction(category_id, transaction_id)
        when "delete" then delete_transaction(category_id, transaction_id)
        when "next" then puts "next_month" # HARDCODE!!!
        when "prev" then puts "prev_month" # HARDCODE!!!
        end
      rescue HTTParty::ResponseError => e
        puts JSON.parse(e.message)["errors"].first
      end
      print_transactions_table(category_name, @transactions)
      action, transaction_id = select_transaction_menu
    end
  end
end
