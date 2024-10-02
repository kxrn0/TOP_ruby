# frozen_string_literal: true

# Tic-Tac-Toe
# Call `.play` to start the game.
class Game
  WINNING_CONDS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize
    reset
  end

  def reset
    @board = Array.new 9
    @player_idx = 0
    @playing = true
  end

  def player_input(choices, prompt, error)
    loop do
      print prompt
      choice = gets.chomp

      return choice if choices.include? choice

      puts error
    end
  end

  def enter_marker(id, prev = nil)
    loop do
      print "Enter player #{id}'s marker: "
      marker = gets.chomp[0]

      return marker unless marker.nil? || marker == prev

      puts 'Please choose a different marker!'
    end
  end

  def choose_markers
    @marker_a = enter_marker 'a'
    @marker_b = enter_marker 'b', @marker_a
  end

  def choose_turns
    choices = %w[a b]
    prompt = "Who goes first?\n(a) - #{@marker_a}\n(b) - #{@marker_b}\n> "
    error = 'Invalid input! Enter either \'a\' or \'b\'.'
    first = player_input(choices, prompt, error)

    @players = [@marker_a, @marker_b]

    @players.rotate! if first == 'b'
  end

  def choose
    choose_markers
    choose_turns
  end

  def print_board
    puts "
         |     |
      #{@board[0] || ' '}  |  #{@board[1] || ' '}  |  #{@board[2] || ' '}
        0|    1|    2
    -----.-----.-----
         |     |
      #{@board[3] || ' '}  |  #{@board[4] || ' '}  |  #{@board[5] || ' '}
        3|    4|    5
    -----.-----.-----
         |     |
      #{@board[6] || ' '}  |  #{@board[7] || ' '}  |  #{@board[8] || ' '}
        6|    7|    8
    "
  end

  def player_select
    choices = (0..8).to_a.filter { |idx| true unless @board[idx] }

    choices.map!(&:to_s)

    prompt = "It's #{@players[@player_idx]}'s turn. Choose a cell: "
    error = 'Invalid input! Please enter a valid cell!'
    index = player_input(choices, prompt, error).to_i

    @board[index] = @players[@player_idx]
  end

  def full?
    @board.none?(&:nil?)
  end

  def won?
    WINNING_CONDS.any? do |cond|
      callback = ->(marker) { cond.all? { |idx| @board[idx] == marker } }

      callback.call(@marker_a) || callback.call(@marker_b)
    end
  end

  def next_index!
    @player_idx = 1 - @player_idx
  end

  def play_again?
    choices = %w[y n]
    prompt = 'Play again (y / n) ? : '
    error = "Please enter 'y' for YES or 'n' for NO."
    choice = player_input(choices, prompt, error)

    return true if choice == 'y'

    false
  end

  def choose_path(again)
    if again
      reset
    else
      @playing = false
    end
  end

  def turn_order
    print_board
    player_select
    next_index!
  end

  def game_over?
    if won?
      "Player #{@players[next_index!]} wins!"
    elsif full?
      "Game Over! It's A Tie!"
    end
  end

  def play
    while @playing
      choose
      final_message = nil
      until final_message
        turn_order
        final_message = game_over?
      end
      print_board
      puts final_message
      choose_path play_again?
    end
  end
end
