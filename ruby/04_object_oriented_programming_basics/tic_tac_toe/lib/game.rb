# frozen-string-literal: true

require_relative 'game_initializer'
require_relative 'logic_handler'
require_relative 'printer'

# Stores game properties
class Game
  attr_accessor :board, :players, :turn, :round, :ties
  attr_reader   :logic_handler, :printer

  HELP_OPTIONS = ((1..9).to_a.map(&:to_s) + %w[h b s c r n k e]
                 .reduce([]) { |arr, curr| arr.push curr, curr.upcase })
                 .freeze

  def self.help_options
    HELP_OPTIONS
  end

  def initialize
    @initializer = GameInitializer.new self
    @logic_handler = LogicHandler.new self
    @printer = Printer.new self
    @board = nil
    @players = [nil, nil]
    @turn = nil
    @round = nil
    @ties = nil
  end

  def start
    @initializer.set_up_game

    @printer.print_help
    @printer.deep_sleep

    @logic_handler.play
  end
end
