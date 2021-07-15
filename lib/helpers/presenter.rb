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

    def print_table(type, formated_date, categories)
      table = Terminal::Table.new
      table.title = "#{type.capitalize}s\n#{formated_date}"
      table.headings = %w[ID Category Total]
      table.rows = categories.map { |item| [item[:id], item[:name], item[:total]] }
      puts "\r#{table}"
    end

    def print_transactions_table(name, formated_date, transactions)
      table = Terminal::Table.new
      table.title = "#{name.capitalize}\n#{formated_date}"
      table.headings = %w[ID Date Amount Notes]
      table.rows = transactions.map { |item| [item[:id], item[:date], item[:amount], item[:notes]] }
      puts "\r#{table}"
    end

    def self.print_bye
      message = ["####################################",
                 "#    Thanks for using Expensable   #",
                 "####################################"]
      message.join("\n")
    end
  end
end
