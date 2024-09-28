# frozen_string_literal: true

# Tic-Tac-Toe game, call init to play
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

  def init
    set_up
    play
  end

  def player_input(choices, prompt, error)
    loop do
      print prompt
      choice = gets.chomp

      return choice if choices.include? choice

      puts error
    end
  end

  def get_marker(id, prev = nil)
    loop do
      print "Enter player #{id}'s marker: "
      marker = gets.chomp[0]

      return marker unless marker.nil? || marker == prev

      puts 'Please choose a different marker!'
    end
  end

  def set_up_markers
    @marker_a = get_marker 'a'
    @marker_b = get_marker 'b', @marker_a
  end

  def set_up_turns
    choices = %w[a b]
    prompt = "Who goes first?\n(a) - #{@marker_a}\n(b) - #{@marker_b}\n> "
    error = 'Invalid input! Enter either \'a\' or \'b\'.'
    first = player_input(choices, prompt, error)

    @players = [@marker_a, @marker_b]

    @players.rotate! if first == 'b'
  end

  def set_up
    @board = Array.new 9
    @player_idx = 0
    @playing = true

    set_up_markers
    set_up_turns
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

  def board_full?
    @board.none?(&:nil?)
  end

  def winner?
    WINNING_CONDS.any? do |cond|
      callback = ->(marker) { cond.all? { |idx| @board[idx] == marker } }

      callback.call(@marker_a) || callback.call(@marker_b)
    end
  end

  def next_index!
    @player_idx = 1 - @player_idx
  end

  def choose_path(again)
    if again
      set_up
    else
      @playing = false
    end
  end

  def play_again?
    choices = %w[y n]
    prompt = 'Play again (y / n) ? : '
    error = "Please enter 'y' for YES or 'n' for NO."
    choice = player_input(choices, prompt, error)

    return true if choice == 'y'

    false
  end

  def play
    while @playing
      print_board

      if winner?
        puts "Player #{@players[next_index!]} wins!"

        choose_path play_again?
      elsif board_full?
        puts "Game Over! It's A Tie!"

        choose_path play_again?
      else
        player_select
        next_index!
      end
    end
  end
end
