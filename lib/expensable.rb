require "json"
require_relative "./handlers/session"
require_relative "./helpers/presenter"
require_relative "./helpers/requester"
require_relative "./services/session"

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
        when "create_user" then create_user
        end
      rescue HTTParty::ResponseError => e
        @token = nil
        puts JSON.parse(e.message)["errors"].first
      end
      action, _id = select_main_menu
    end
  end

  def create_user; end
end
