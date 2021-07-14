require "uri"
module Helpers
  module Requester
    def self.login_form
      gets_with_options %w[login create_user exit]
    end

    def self.select_transaction
      options_array = ["create", "show ID", "update ID", "delete ID",
                       "\nadd-to ID", "toggle", "next", "prev", "logout"]
      gets_with_options options_array
    end

    def self.login_user
      username = gets_string("Username: ")
      password = gets_string("Password: ", length: 6)
      { username: username, password: password }
    end

    def self.create_user
      email = valid_email("Email: ")
      password = gets_string("Password: ", length: 6)
      first_name = gets_string("First name: ", required: false)
      last_name = gets_string("Last name: ", required: false)
      phone = valid_phone("Phone: ")
      { email: email, password: password,
        first_name: first_name, last_name: last_name,
        phone: phone }
    end

    def self.valid_email(label)
      regex = URI::MailTo::EMAIL_REGEXP
      print label
      input = gets.chomp
      puts input.match?(/#{regex}/)
      until input.match?(/#{regex}/)
        puts "#{label}Invalid format"
        print label
        input = gets.chomp
      end
      input
    end

    def self.valid_phone(label)
      phone = '^([+](51)[ ])?(\d{9})'
      print label
      input = gets.chomp
      until input.match?(/#{phone}/)
        puts "#{label}Required format: +51 111222333 or 111222333"
        print label
        input = gets.chomp
      end
      input
    end

    def self.gets_string(label, length: 0, required: true)
      print label
      input = gets.chomp
      return nil if !required && input.empty?

      while input.empty? || input.size < length
        puts "#{label} Cannot be blank" if input.empty?
        puts "#{label} minimum size is #{length}" if input.size < length
        print label
        input = gets.chomp
      end
      input
    end

    def self.gets_with_options(options, required: true)
      puts options.join(" | ")
      print "> "
      input = gets.chomp.split.map(&:strip)
      return nil if input.empty? && !required

      until options.include? input[0]
        return nil if input.empty? && !required

        puts "Invalid option"
        print "> "
        input = gets.chomp.split.map(&:strip)
      end
      action, id = input
      [action, id.to_i]
    end
  end
end
