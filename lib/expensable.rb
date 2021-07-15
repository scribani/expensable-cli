require "json"
require_relative "./handlers/session"
require_relative "./helpers/presenter"
require_relative "./helpers/requester"
require_relative "./services/session"
require_relative "./services/user"

class Expensable
  include Helpers::Presenter
  include Helpers::Requester
  include Handlers::Session

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
      # category_page if @token
      action, _id = select_main_menu
    end
  end
end
