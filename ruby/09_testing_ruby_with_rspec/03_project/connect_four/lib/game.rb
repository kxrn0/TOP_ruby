# Connect Four
# call `.play` to start
class Game
  def initialize(width = 9, height = 6)
    @players = ['x', 'o']

    reset width, height
  end

  def reset_board
    @board = Array.new @width * @height
  end

  def reset(width, height)
    @width = width
    @height = height
    @winner = nil
    @current_player_index = 0
    @is_playing = true

    reset_board
  end

  def player_input(choices, prompt, error)
    loop do
      print prompt

      choice = gets.chomp

      return choice if choices.include? choice

      puts error
    end
  end

  def yes_or_no?(prompt)
    choices = ['y', 'n']
    error = "Please enter either 'y' or 'n'!"
    choice = player_input choices, prompt, error

    return choice == 'y'
  end

  def choose_turns
    choices = ['x', 'o']
    prompt = 'Who should go first (x / o)? > '
    error = 'Invalid input! Please enter a valid choice!'
    choice = player_input choices, prompt, error

    @current_player_index = 1 if choice == 'o'
  end

  def resize?
    prompt = "Board size: #{@width} by #{@height}. Do you wish to change it (y / n)? >"
    yes_or_no? prompt
  end

  def change_dimension(var)
    choices = (6..18).to_a.map(&:to_s)
    prompt = "Enter #{var} (min: 6, max: 18) > "
    error = "Invalid input! #{var} has to be in [6, 18]! try again!"
    result = player_input choices, prompt, error
    value = result.to_i

    instance_variable_set("@#{var}", value)
  end

  def resize_board
    return unless resize?

    change_dimension 'width'
    change_dimension 'height'
    reset_board
  end

  def print_intro
    puts 'Connect Four. Copyright kxrn0, 1966.'
  end

  def compute_index(column)
    y = @height - 1

    @height.times do |h|
      index = column + (y - h) * @width

      return index unless @board[index]
    end
  end

  def valid_columns
    col = @width - 1
    (0..col).to_a.map(&:to_s).filter { |idx| true unless @board[idx.to_i] }
  end

  def swap!
    @current_player_index = 1 - @current_player_index
  end

  def print_board
    puts 'board'
  end

  def turn_order
    print_board

    current = @players[@current_player_index]
    col = @width - 1
    choices = valid_columns
    prompt = "It's #{current}'s turn! enter a column to insert the stone [0, #{col}] > "
    error = 'That column is unavailable! please choose a different one!'
    selected = player_input(choices, prompt, error).to_i

    index = compute_index selected
    @board[index] = @players[@current_player_index]
    swap!
  end

  def check_axis(a, b, idx)
    winner = nil
    count = 0

    a.times do |i|
      winner = nil
      count = 0

      b.times do |j|
        index = idx.call i, j
        char = @board[index]

        if char == winner
          count += 1
        else
          winner = char
          count = 0
        end

        if count >= 4 && winner
          return winner
        end
      end
    end

    if count >= 4 && winner
      return winner
    end
  end

  def check_x
    idx = Proc.new { |y, x| x + y * @width }

    check_axis @width, @height, idx
  end

  def check_y
    idx = Proc.new { |x, y| x + y * @width }

    check_axis @height, @width, idx
  end

  def full?
    valid_columns.empty?
  end

  def game_over?
    full? || @winner
  end

  def print_ending
    puts 'bye'
  end

  def play_again?
    # hi
  end

  def check_diagonal
  end

  def compute_winner
  end

  def play
    print_intro
    while @is_playing
      choose_turns
      resize_board

      until game_over?
        turn_order
        @winner = compute_winner
      end

      print_ending
      play_again?
    end
  end
end
