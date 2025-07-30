# frozen_string_literal: true

require_relative 'inputable'
require_relative 'player'

# Game
class Game
  include Inputable

  def initialize
    @board = nil
    @players = [Player.new('x'), Player.new('o')]
    @turn = nil
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
  end

  def print_intro
    puts 'hi'
  end

  def print_instructions
    puts 'press r to continue...'
  end

  def init_board
    @board = Board.new
  end

  def choose_index
    prompt = '> '
    test = proc { |input| /^[12]$/.match? input }
    error_message = "Please enter '1' or '2'!"
    input = get_input prompt, test, error_message

    input.to_i
  end

  def print_mover_instructions
    instructions = "Who should go first?\n\n(1) - x\n(2) - o\n"

    puts instructions
  end

  def print_first_mover
    name = @players[@turn].name

    puts "「#{name}」 will go first"
  end

  def choose_first_mover
    print_mover_instructions

    @turn = choose_index

    print_first_mover
  end

  def set_up
    print_intro

    init_board
    choose_first_mover

    print_instructions
  end

  def game_loop
  end
end
