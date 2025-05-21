# frozen-string-literal: true

require_relative 'inputable'
require_relative 'player'
require_relative 'board'

# Initializes the state of a Game object.
module GameInitializable
  private

  include Inputable

  def set_up_board
    @board = Board.new
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

    @turn = compute_turn choice
  end

  def set_up_players(naughts_name, crosses_name)
    player_naughts = Player.new naughts_name
    player_crosses = Player.new crosses_name

    @players = [player_naughts, player_crosses]
  end

  def decide_names
    error_message = 'please enter a visible name!'

    prompt = 'who will be naughts? > '
    naughts_name = get_input prompt, error_message

    prompt = 'who will be crosses? > '
    crosses_name = get_input prompt, error_message, [], [naughts_name]

    [naughts_name, crosses_name]
  end

  def set_up_game
    naughts_name, crosses_name = decide_names

    set_up_players naughts_name, crosses_name

    set_up_turn naughts_name, crosses_name

    set_up_board
  end
end
