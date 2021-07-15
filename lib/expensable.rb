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
        when "show" then show_category(id)
        when "update" then update_category(id)
        when "delete" then delete_category(id)
        when "add-to" then add_to_category(id)
        when "toggle" then toggle_category(id)
        when "next" then puts "next_month" # HARDCODE!!!
        when "prev" then puts "prev_month" # HARDCODE!!!
        end
      rescue HTTParty::ResponseError => e
        puts JSON.parse(e.message)["errors"].first
      end
      # transaction_page if @token
      print_updated_table
      action, id = select_category_menu
    end
  end
end
