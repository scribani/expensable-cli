module Helpers
  module Presenter
    def self.print_welcome
      message = ["#############################",
                 "#    Welcome to Keepable    #",
                 "#############################"]
      message.join("\n")
    end

    def id_form
      print "Expression ID: "
      gets.chomp
    end

    def print_expenses_table(list)
      table = Terminal::Table.new
      table.title = list[:transaction_type].capitalize
      table.headings = %w[ID Category Total]
      table.rows = list.map { |item| [item[:id], item[:name], item[:total]] }
      puts "\r#{table}"
    end

    def print_incomes_table(list)
      table = Terminal::Table.new
      table.title =  list["Income"]
      table.headings = %w[ID Category Total]
      table.rows = [
        [item["ID"], item["Category"], item["Total"]]
      ]
      puts "\r#{table}"
    end

    def print_transactions_table(list)
      table = Terminal::Table.new
      table.title =  list[:name]
      table.headings = %w[ID Date Amount Notes]
      table.rows = list.map { |item| [item[:id], item[:date], item[:amount], item[:notes]] }
      puts "\r#{table}"
    end

    def self.print_bye
      message = ["####################################",
                 "#    Thanks for using Expensable    #",
                 "####################################"]
      message.join("\n")
    end
  end
end
