# frozen-string-literal: true

require_relative 'game_initializer'
require_relative 'logic_handler'

# Manages the game
# call `start` to start the game
class Game
  attr_reader :players, :board, :turn, :is_running, :round

  HELP_MESSAGE = <<~HEREDOC
    Help:
      h             - show help menu
      b             - show board
      s             - show current scores
      c             - toggle cell numbers
      r             - restart game
      k             - reset everything
      e             - terminate program
      <cell_number> - choose a cell
  HEREDOC

  HELP_OPTIONS = ((1..9).to_a.map(&:to_s) + %w[h b s c r n k e]
                 .reduce([]) { |arr, curr| arr.push curr, curr.upcase })
                 .freeze

  def self.help_message
    HELP_MESSAGE
  end

  def self.help_options
    HELP_OPTIONS
  end

  def initialize
    @initializer = GameInitializer.new self
    @logic_handler = LogicHandler.new self
    @board = nil
    @players = [nil, nil]
    @turn = 0
    @show_cell_numbers = true
    @is_running = false
    @round = nil
  end

  def print_help
    puts "\n#{HELP_MESSAGE}"
  end

  def deep_sleep
    puts "\nThe game is loading, please wait warmly...\n"
    sleep 3
  end

  def start
    @initializer.set_up_game

    print_help
    deep_sleep

    @logic_handler.play
  end
end
