# frozen_string_literal: true

require_relative 'inputable'
require_relative 'board'

# Handles the state
class GameStateHandler
  include Inputable

  def initialize(game)
    @game = game
  end

  def set_up
    puts "\n=+=+= CONNECT FOUR! =+=+=\ncopyright @kxrn0, 1977\n\n"

    @game.board = Board.new

    choose_first_mover

    puts "Enter a column number or `exit` to terminate the program (not recommended).\n"
  end

  def play_again
    return unless @game.is_running

    prompt = 'Play again (y / n)? > '
    test = proc { |input| /^(y|n|yes|no)$/i.match? input }
    error_message = 'Please enter `y` or `n`!'
    choice = get_input prompt, test, error_message

    @game.is_running = /^(y|yes)$/i.match? choice
  end

  private

  def choose_index
    prompt = '> '
    test = proc { |input| /^[12]$/.match? input }
    error_message = "Please enter '1' or '2'!"
    input = get_input prompt, test, error_message

    input.to_i
  end

  def print_first_mover
    name = @game.current_name

    puts "「#{name}」 will go first"
  end

  def choose_first_mover
    puts "Who should go first?\n(1) - x\n(2) - o\n"

    @game.turn = choose_index - 1

    print_first_mover
  end
end
