# frozen-string-literal: true

# Adds support for handling console input.
module Inputable
  private

  def validate_input(input, options, excluded, error_message)
    if excluded.include? input
      message = 'value already taken! try another one!'

      [message, false]
    elsif input != '' && ((options.include? input) || options.empty?)
      ['', true]
    else
      [error_message, false]
    end
  end

  def get_input(prompt, error_message, options = [], excluded = [])
    bad_input = true

    print "\n#{prompt}"

    while bad_input

      input = gets.chomp.strip

      message, result = validate_input input, options, excluded, error_message

      return input if result

      print "\n#{message}\n\n#{prompt}"
    end
  end
end
