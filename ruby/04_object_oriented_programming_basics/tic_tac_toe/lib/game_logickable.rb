# frozen-string-literal: true

require_relative 'inputable'

# It handles the game logic
module GameLogickable
  private

  include Inputable

  def act_on_move(choice)
    number = choice.to_i
  end

  def select_option
    name = @players[@turn].name
    prompt = "「#{name}」 > "
    error_message = 'enter a valid help option or an empty cell number!'
    options = HELP_OPTIONS
    excluded = @board.cells.each_with_object([]) do |current, numbers|
      numbers.push current.number unless current.empty?
    end
    choice = get_input prompt, error_message, options, excluded

    choice.downcase
  end

  def act_on_option
    # choice = select_option

    # case choice
    # when 'h', 'H'
    #   print_help
    # when 'b', 'B'
    #   @board.draw
    # when 'c', 'C'
    #   @show_cell_numbers = !@show_cell_numbers
    # when 'r', 'R'
    #   puts 'restarting this game'
    # when 'n', 'N'
    #   puts 'NEW GAME!!'
    # when 'k', 'K'
    #   puts 'resetting everything!'
    # when 'e'
    #   puts 'fuck!'
    # else
    #   act_on_move choice
    # end
  end

  def update_board
  end

  def loop_game
    print_board
    act_on_option
  end
end
