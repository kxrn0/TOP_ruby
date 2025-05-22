# frozen-string-literal: true

require_relative 'game_initializer'
require_relative 'logic_handler'

# Manages the game
class Game
  attr_reader :player, :board

  HELP_MESSAGE = <<~HEREDOC
    Help:
      h             - show help menu
      b             - show board
      c             - toggle cell numbers
      r             - restart this game
      n             - new game
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
  end

  def start
    @initializer.set_up_game
    @logic_handler.play
  end
end
