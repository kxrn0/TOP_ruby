# frozen-string-literal: true

require_relative 'game_initializer'
require_relative 'logic_handler'

# Manages the game
class Game
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

  HELP_OPTIONS = ((1..9).to_a.map(&:to_s) + %w[h b c r n k e]
                 .reduce([]) { |arr, curr| arr.push curr, curr.upcase })
                 .freeze

  def initialize
    @initializer = GameInitializer.new self
    @logic_handler = LogicHandler.new self
    @board = nil
    @players = [nil, nil]
    @turn = 0
    @show_cell_numbers = true
  end

  def start
    print_welcome_message

    @initializer.set_up_game

    print_help
    deep_sleep
    play
  end

  private

  def print_help
    puts "\n#{HELP_MESSAGE}"
  end

  def deep_sleep
    puts "\nThe game is loading, please wait warmly...\n"
    sleep 3
  end

  def print_welcome_message
    puts 'TIC TAC TOE'
    puts "copyright @kxrn0, 1985\n\n"
    puts 'The game will use naughts (o), and crosses (x) for the markers.'
  end

  def act_on_move(cell_index)
    @board.cells[cell_index].marker = @players[@turn].marker

    winner = @board.compute_winner

    if winner
      puts 'Game Over!'
      puts "#{@players[@turn].name} is the winner!"

      prompt = 'Play again (y / n)? > '
      error_message = "please enter 'y' or 'n'!"
      options = %w[y n Y N]
      choice = get_input prompt, error_message, options
    else
      puts "it's not over yet!"
    end
  end

  def play
    terminate_program = false

    while terminate_program == false
      print_board

      made_move = false

      while made_move == false
        option = select_option

        case option
        when 'h', 'H'
          print_help
        when 'b', 'B'
          @board.draw
        when 'c', 'C'
          @show_cell_numbers = !@show_cell_numbers
          @board.draw
        when 'r', 'R'
          puts 'restarting this game'
        when 'n', 'N'
          puts 'NEW GAME!!'
        when 'k', 'K'
          puts 'resetting everything!'
        when 'e'
          puts 'fuck!'
          made_move = true
          terminate_program = true
        else
          cell_index = option.to_i - 1
          act_on_move cell_index
          made_move = true
        end
      end
    end
  end
end
