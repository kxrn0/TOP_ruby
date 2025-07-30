# frozen_string_literal: true

# Adds support for input
module Inputable
  def get_input(prompt, test, error_message)
    loop do
      print prompt
      input = gets.chomp

      return input if test.call input

      puts error_message
    end
  end
end
