# Connect Four
# call `.play` to start
class Game
  def initialize(rows = 6, cols = 9)
    @rows = rows
    @cols = cols
    reset @rows, @cols
  end

  def reset(rows, cols)
    @board = Array.new rows * cols
    @winner = nil
    @players = ['x', 'o']
    @current_player_index = 0
    @is_playing = true
  end

  def player_input(choices, prompt, error)
    loop do
      print prompt

      choice = gets.chomp

      return choice if choices.include? choice

      puts error
    end
  end

  def choose_turns
    choices = ['x', 'o']
    prompt = 'Who should go first (x / o)? > '
    error = 'Invalid input! Please enter a valid choice!'
    choice = player_input choices, prompt, error

    @current_player_index = 1 if choice == 'o'
  end

  def print_intro
    puts 'Connect Four. Copyright kxrn0, 1966.'
  end

  def play
    print_intro
    choose_turns
    while @is_playing
      print_board
      turn_order until game_over?
      print_ending
      play_again?
    end
  end
end
