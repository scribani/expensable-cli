module Helpers
  module Validations
    def valid_email(label)
      regex = '\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z'
      print label
      puts regex
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
        puts "#{label} minimum size is #{length}" if input.size < length
        print label
        input = gets.chomp
      end
      input
    end

    def valid_login(label)
      print label
      input = gets.chomp

      while input.empty?
        puts "#{label}Cannot be blank" if input.empty?
        print label
        input = gets.chomp
      end
      input
      # FALTA EL RESPONSE BODY MESSAGE PARA VERIFICAR SI ES EMAIL CORRERCTO O NO
    end

    def gets_with_options(options, required: true)
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
