# frozen_string_literal: true

require_relative 'inputable'
require_relative 'board'
require_relative 'player'

# manages the lifecycle of the game
# call the instance method`start` to start the game
class Game
  OPTIONS = ((1..9).to_a.map(&:to_s) + ['exit']).freeze
  DEEP_SLEEP = 1

  include Inputable

  def initialize
    @board = nil
    @players = [Player.new('x'), Player.new('o')]
    @turn = nil
    @is_running = true
    @is_gaming = true
  end

  def start
    game_loop
  end

  private

  def set_up
    puts "\nRandomly choosing go goes first, please wait warmly...\n"

    sleep DEEP_SLEEP

    @board = Board.new
    @turn = rand 2
    @is_gaming = true

    puts "\nEnter an empty cell number, or 'exit' to quit.\n"

    first = @players[@turn].marker

    puts "\n「#{first}」 goes first\n"
  end

  def obtain_user_input
    name = @players[@turn].marker
    prompt = "「#{name}」 > "
    error_message = "Invalid input! please enter an empty cell number or 'exit' to terminate the program!"

    get_input prompt, error_message, OPTIONS, @board.taken
  end

  def terminate
    @is_gaming = false
    @is_running = false

    puts "\nShutting down...\n"

    sleep DEEP_SLEEP
  end

  def update_board(cell_number)
    marker = @players[@turn].marker

    @board.set cell_number, marker
  end

  def handle_input
    input = obtain_user_input

    if input == 'exit'
      terminate
    else
      update_board input
    end
  end

  def print_scores
    x = @players[0]
    o = @players[1]
    puts <<~HEREDOC
      WINS:
        「#{x.marker}」 : #{x.wins}
        「#{o.marker}」 : #{o.wins}
    HEREDOC
  end

  def update_winner(winner)
    player = @players.find { |player| player.marker == winner }

    player.wins += 1
  end

  def print_end_message(winner)
    if winner.nil?
      puts "\n\nGAME OVER! it's a tie!"

    else
      puts "GAME OVER! 「#{winner}」 is the winner!"

      update_winner winner
    end

    print_scores
  end

  def update
    winner = @board.compute_winner

    if winner || @board.full?
      @is_gaming = false

      print_end_message winner
    else
      @turn = 1 - @turn
    end
  end

  def play_again?
    prompt = 'Play again (yes / no)? > '
    error_message = "Invalid input! enter 'yes' or 'no'!"
    options = %w[yes no]
    choice = get_input prompt, error_message, options

    choice == 'yes'
  end

  def game_loop
    while @is_running
      set_up

      while @is_gaming
        @board.draw

        handle_input

        update if @is_running
      end

      @is_running = play_again? if @is_running
    end
  end
end
