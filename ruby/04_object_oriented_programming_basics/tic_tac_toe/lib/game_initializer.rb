# frozen-string-literal: true

require_relative 'inputable'
require_relative 'game'
require_relative 'player'
require_relative 'board'

# Initializes the state of a Game object.
class GameInitializer
  include Inputable

  def initialize(game)
    @game = game
  end

  def set_up_game
    print_welcome_message

    naughts_name, crosses_name = decide_names

    set_up_players naughts_name, crosses_name

    set_up_turn naughts_name, crosses_name

    set_up_board

    print_help
    deep_sleep
  end

  private

  def print_welcome_message
    puts 'TIC TAC TOE'
    puts "copyright @kxrn0, 1985\n\n"
    puts 'The game will use naughts (o), and crosses (x) for the markers.'
  end

  def print_help
    puts "\n#{Game.help_message}"
  end

  def deep_sleep
    puts "\nThe game is loading, please wait warmly...\n"
    sleep 3
  end

  def set_up_board
    @game.board = Board.new
  end

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

  def create_order_message(naughts_name, crosses_name)
    <<~HEREDOC
      Who will go first?
        (a) - o 「#{naughts_name}」
        (b) - x 「#{crosses_name}」
        (c) - random
      Enter a, b, or c >#{' '}
    HEREDOC
  end

  def decide_order_choice(naughts_name, crosses_name)
    prompt = (create_order_message naughts_name, crosses_name).chomp
    error_message = 'please enter a valid choice!'
    options = %w[a b c A B C]

    get_input prompt, error_message, options
  end

  def set_up_turn(naughts_name, crosses_name)
    choice = (decide_order_choice naughts_name, crosses_name).downcase

    turn = compute_turn choice

    @game.turn = turn
  end

  def set_up_players(naughts_name, crosses_name)
    player_naughts = Player.new naughts_name
    player_crosses = Player.new crosses_name

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
