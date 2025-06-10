# frozen-string-literal: true

require_relative 'coder'
require_relative 'game'

# Flesh guesser
class HumanGuesser
  def initialize(game)
    @game = game
  end

  def guess
    done = false

    until done
      input = valid_guess

      return input unless input.nil?

      puts 'Please enter a valid guess!'

    end
  end

  def give(hints)
    puts "hints: #{hints}"
  end

  private

  def valid_guess
    print "\nenter guess (#{@game.guesses} / #{Game::INIT_GUESSES}) > "
    input = gets.chomp.downcase
    is_code = input =~ /^[abcdef]{4}$/
    is_exit = input == 'exit'
    is_valid = is_exit || is_code

    input if is_valid
  end
end
