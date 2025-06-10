# frozen-string-literal: true

require_relative 'inputable'
require_relative 'ai_coder'
require_relative 'human_coder'
require_relative 'ai_guesser'
require_relative 'human_guesser'

# Mastermind game
# Call `start` to start the game
class Game
  attr_reader :guesses

  include Inputable

  INTRO = <<~HEREDOC
    The game consists of cracking a #{Coder::CODE_SIZE} letter code composed of the characters #{Coder::PEGS}

    For every guess there will be some hints.

    A + means a letter is in the correct spot.
    A - means a letter is in the code, but in the wrong spot.

    The guesser has 12 guesses.

    Enter a guess, or 'exit' to terminate the program (not recommended).
  HEREDOC

  INIT_GUESSES = 12

  def initialize
    @coder = nil
    @guesser = nil
    @guesses = 0
    @running = true
    @gaming = true
    @terminated = false
  end

  def play
    puts INTRO

    while @running
      setup
      game_loop

      @running = play_again? unless @terminated
    end
  end

  private

  def play_again?
    prompt = 'Play again (yes / no)? > '
    error_message = "Please enter 'yes' or 'no'!"
    options = %w[yes no]
    input = get_input prompt, error_message, options

    input == 'yes'
  end

  def terminate
    @gaming = false
    @running = false
    @terminated = true
  end

  def handle_game_over(won)
    state = won ? 'WIN' : 'LOST'

    puts "\nGAME OVER! YOU #{state}!"

    puts "THE CODE WAS #{@coder.code}" unless won

    @gaming = false
  end

  def handle_guess(guess)
    @guesses -= 1

    if @guesses.zero?
      handle_game_over false
    else
      @guesser.give @coder.hints guess
    end
  end

  def handle_input(input)
    if input == 'exit'
      terminate
    elsif input == @coder.code
      handle_game_over true
    else
      handle_guess input
    end
  end

  def game_loop
    handle_input @guesser.guess while @gaming
  end

  def human_coder?
    prompt = 'Do you want to be the guesser (yes / no)? > '
    error_message = "Please enter 'yes' or 'no'!"
    options = %w[yes no]
    choice = get_input prompt, error_message, options

    choice == 'no'
  end

  def setup_players
    if human_coder?
      @coder = HumanCoder.new
      @guesser = AIGuesser.new self
    else
      @coder = AICoder.new
      @guesser = HumanGuesser.new self
    end
  end

  def setup
    setup_players

    @coder.reset_code

    @gaming = true
    @guesses = INIT_GUESSES
  end
end
