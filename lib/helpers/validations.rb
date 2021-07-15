require "date"
module Helpers
  module Validations
    def valid_email(label)
      regex = '\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z'
      print label

      input = gets.chomp
      until input.match?(/#{regex}/i)
        puts "#{label}Invalid format"
        print label
        input = gets.chomp
      end
      input
    end

    def valid_phone(label)
      regex = '^(\+51 )?(\d{9})$'
      print label
      input = gets.chomp
      return nil if input.empty?

      until input.match?(/#{regex}/)
        puts "#{label}Required format: +51 111222333 or 111222333"
        print label
        input = gets.chomp
      end
      input
    end

    def valid_string(label, length: 0, required: true)
      print label
      input = gets.chomp
      return nil if !required && input.empty?

      while input.empty? || input.size < length
        puts "#{label}Minimum #{length} characters" if input.size < length
        print label
        input = gets.chomp
      end
      input
    end

    def valid_input_no_empty(label)
      print label
      input = gets.chomp

      while input.empty?
        puts "#{label}Cannot be blank" if input.empty?
        print label
        input = gets.chomp
      end
      input
    end

    def valid_transaction_type(label)
      print label
      input = gets.chomp.downcase

      until %w[expense income].include?(input)
        puts  "#{label}Only income or expense"
        print label
        input = gets.chomp.downcase
      end
      input
    end

    def positive_integer(label)
      print label
      input = gets.chomp.to_i

      until input.positive?
        puts "#{label}Cannot be zero"
        print label
        input = gets.chomp.to_i
      end
      input
    end

    def valid_date(label)
      print label
      input = gets.chomp

      until validate_date(input)
        puts "#{label}Required format: YYYY-MM-DD"
        print label
        input = gets.chomp
      end
      Date.strptime(input).to_s
    end

    def validate_date(input)
      date_format = "%Y-%m-%d"
      DateTime.strptime(input, date_format)
      true
    rescue ArgumentError
      false
    end

    def gets_with_options(options)
      puts options.join(" | ")
      print "> "
      input = gets.chomp.split.map(&:strip)
      until options.include? input[0]
        puts "Invalid option"
        print "> "
        input = gets.chomp.split.map(&:strip)
      end
      action, id = input
      [action, id.to_i]
    end

    def valid_add_to
      amount = positive_integer("Amount: ")
      date = valid_date("Date: ")
      notes = valid_string("Notes: ", required: false)
      { amount: amount, date: date, notes: notes }
    end
  end
end
