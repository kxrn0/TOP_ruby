# frozen-string-literal: true

require_relative 'inputable'
require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'round'

# Initializes the state of a Game object.
class GameInitializer
  include Inputable

  def initialize(game)
    @game = game
  end

  def set_up_game
    @game.printer.print_welcome_message

    naughts_name, crosses_name = decide_names
    set_up_players naughts_name, crosses_name
    set_up_turn naughts_name, crosses_name

    @game.board = Board.new
    @game.round = Round.new 1, @game.turn
    @game.ties = 0

    @game.logic_handler.reset
  end

  private

  def compute_turn(choice)
    case choice
    when 'a'
      0
    when 'b'
      1
    when 'c'
      rand 2
    end
  end

  def decide_order_choice(naughts_name, crosses_name)
    prompt = (@game.printer.create_order_message naughts_name, crosses_name)
             .chomp
    error_message = 'please enter a, b or c!'
    options = %w[a b c A B C]

    get_input prompt, error_message, options
  end

  def set_up_turn(naughts_name, crosses_name)
    choice = (decide_order_choice naughts_name, crosses_name).downcase

    turn = compute_turn choice

    @game.turn = turn
  end

  def set_up_players(naughts_name, crosses_name)
    player_naughts = Player.new 'o', naughts_name
    player_crosses = Player.new 'x', crosses_name

    @game.players = [player_naughts, player_crosses]
  end

  def decide_names
    error_message = 'please enter a visible name!'

    prompt = 'who will be naughts? > '
    naughts_name = get_input prompt, error_message

    prompt = 'who will be crosses? > '
    crosses_name = get_input prompt, error_message, [], [naughts_name]

    [naughts_name, crosses_name]
  end
end
