require_relative "./lib/expensable"
require_relative "./lib/helpers/presenter"

puts Helpers::Presenter.print_welcome
expensable = Expensable.new
expensable.start
puts Helpers::Presenter.print_bye
