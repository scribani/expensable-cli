require "json"
require "date"
require "terminal-table"
require_relative "./handlers/session"
require_relative "./handlers/transactions"
require_relative "./handlers/categories"
require_relative "./helpers/presenter"
require_relative "./helpers/requester"
require_relative "./helpers/filters"
require_relative "./services/session"
require_relative "./services/user"
require_relative "./services/category"
require_relative "./services/transaction"

class Expensable
  include Helpers::Presenter
  include Helpers::Requester
  include Helpers::Filters
  include Handlers::Session
  include Handlers::Transactions
  include Handlers::Categories

  def initialize
    @token = nil
    @categories = []
    @transactions = []
    @date = Date.today
    @type = "expense"
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

  def category_page
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
        when "toggle" then @type = @type == "expense" ? "income" : "expense"
        when "next" then puts @date += 30
        when "prev" then puts @date -= 30
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
    print_updated_transaction_table(category_id)
    action, transaction_id = select_transaction_menu
    until action == "back"
      begin
        case action
        when "add" then add_transaction(category_id)
        when "update" then update_transaction(category_id, transaction_id)
        when "delete" then delete_transaction(category_id, transaction_id)
        when "next" then puts @date += 30
        when "prev" then puts @date -= 30
        end
      rescue HTTParty::ResponseError => e
        puts JSON.parse(e.message)["errors"].first
      end
      print_updated_transaction_table(category_id)
      action, transaction_id = select_transaction_menu
    end
  end

  private

  def format_date(date)
    date_parsed = Date.parse(date)
    date_parsed.strftime("%B %Y")
  end

  def print_updated_table
    @categories = Services::Category.list(@token)
    by_type = filter_by_type(@categories, @type)
    by_type.map do |category|
      by_date = filter_by_date(category[:transactions], @date.to_s)
      category[:total] = calculate_total(by_date)
    end
    formated_date = format_date(@date.to_s)
    print_table(@type, formated_date, by_type)
  end

  def print_updated_transaction_table(category_id)
    @transactions = Services::Transaction.list(@token, category_id)
    selected_category = @categories.find { |category| category[:id] == category_id }
    category_name = selected_category[:name]
    filtered_transactions = filter_by_date(@transactions, @date.to_s)
    formated_date = format_date(@date.to_s)
    print_transactions_table(category_name, formated_date, filtered_transactions)
  end
end
