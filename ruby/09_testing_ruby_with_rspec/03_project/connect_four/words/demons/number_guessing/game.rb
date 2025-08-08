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

# Handles initialization
module Initializable
  private

  def set_up
    print_intro
    set_state
    print_instructions
  end

  def print_intro
    puts "\nNUMBER GUESSER\ncopyright by me 1983\n\n"
  end

  def set_state
    @target = rand(1..100)
    @lives = Game::MAX_LIVES
    @is_gaming = true
  end

  def print_instructions
    puts "guess a number between 0 and 100, enter `exit` to terminate the program (not recommended).\n"
  end
end

# Handles logic
module Logickable
  private

  include Inputable

  def game_loop
    while @is_gaming
      guess = make_guess
      update_lives
      handle_guess guess
    end
  end

  def make_guess
    prompt = "#{@lives} / #{Game::MAX_LIVES} > "
    test = proc { |input| /^(\d+|exit)$/i.match?(input) }
    error_message = 'Enter a number or `exit` to terminate!'
    input = get_input(prompt, test, error_message).downcase

    input = input.to_i unless input == 'exit'

    input
  end

  def handle_guess(guess)
    if guess == 'exit'
      terminate
    elsif guess == @target
      game_over true
    elsif dead?
      game_over false
    else
      give_feedback guess
    end
  end

  def game_over(won)
    puts 'GAME OVER!'
    @is_gaming = false

    if won
      puts 'you win!'
    else
      puts "you lost! the number was #{@target}"
    end
  end

  def update_lives
    @lives -= 1
  end

  def dead?
    @lives.zero?
  end

  def give_feedback(guess)
    if guess > @target
      puts 'too high!'
    else
      puts 'too low!'
    end
  end

  def terminate
    @is_gaming = false
    @is_running = false

    deep_sleep
  end

  def deep_sleep
    puts 'SHUTTING DOWN...'
    sleep 1
  end
end

# Handles higher level details
class Game
  MAX_LIVES = 10

  include Initializable
  include Logickable

  def initialize
    @lives = 0
    @target = 0
    @is_running = true
    @is_gaming = true
  end

  def run
    while @is_running
      set_up
      game_loop

      @is_running = play_again? if @is_running
    end
  end

  private

  def play_again?
    yes = /^(y|yes)$/i
    no = /^(n|no)$/i
    prompt = 'play again (y / n)? > '
    test = proc { |input| yes.match?(input) || no.match?(input) }
    error_message = 'please enter `y` or `n`!'
    input = get_input prompt, test, error_message

    @is_running = yes.match? input
  end
end

game = Game.new

game.run
