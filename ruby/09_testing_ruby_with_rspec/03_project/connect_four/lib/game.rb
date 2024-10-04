# Connect Four
# call `.play` to start
class Game
  def initialize(width = 6, height = 9)
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

  def turn_order
    print_board
  end

  def play
    print_intro
    while @is_playing
      choose_turns
      resize_board
      turn_order until game_over?
      print_ending
      play_again?
    end
  end
end
