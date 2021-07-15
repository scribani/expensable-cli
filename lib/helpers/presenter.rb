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
        table.title = "Expenses"
        table.headings = %w[ID Category Total]
        table.rows = list.map { |item| [item["ID"], item["Category"], item["Total"]] }
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
        table.title =  list["Transportation"]
        table.headings = %w[ID Date Amount Notes]
        table.rows = list.map { |item| [item["ID"], item["Date"], item["Amount"], item["Notes"]] }
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