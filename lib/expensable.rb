require_relative "./helpers/presenter"
require_relative "./helpers/requester"

class Expensable
  include Helpers::Presenter
  include Helpers::Requester

  def initialize
    @token = nil
    @categories = []
    @transactions = []
  end

  def start
    action, _id = select_main_menu
    until action == "exit"
      case action
      when "login" then login
      when "create_user" then create_user
      end
      action, _id = select_main_menu
    end
  end

  def login; end

  def create_user;end
end
