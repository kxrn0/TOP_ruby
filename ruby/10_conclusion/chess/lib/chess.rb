# frozen_string_literal: true

require_relative 'inputable'
require_relative 'file_manager'
require_relative 'board'
require_relative 'game'
require_relative 'player'

# Handles the main lifecycle of the program.
class Chess
  def initialize
    @is_running = true
    @turn = 0
    @players = [Player.new(Player::BLACK), Player.new(Player.WHITE)]
    @board = Board.new
    @file_manager = FileManager.new
    @game = Game.new self
  end

  def run
    puts "\nthe amazing...\nCHESS!\ncopyright @kxrn0, 1956\n"

    while @is_running
      main_menu

      return unless @is_running

      @game.game_loop
    end
  end

  private

  def choose_nth(nth)
    prompt = '> '
    test = proc { |input| input.to_i.between?(1, nth) }
    error_message = 'Please enter a valid option!'

    get_input prompt, test, error_message
  end

  def handle_turn_option(choice)
    @turn = if choice.between? 1, 2
              choice - 1
            else
              rand 2
            end
  end

  def choose_first_turn
    puts "\nWho goes first?\n"
    puts "\n(1) - x\n(2) - o\n(3) - random\n"

    options = 3
    option = choose_nth options

    handle_turn_option option.to_i
  end

  def new_game
    @board = Board.new

    choose_first_turn
  end

  def choose_game_index(count)
    prompt = '> '
    test = proc { |input| input == 'b' || input.to_i.between?(1, count) } # count < 0
    error_message = 'Please enter a valid option!'

    get_input prompt, test, error_message
  end

  def setup_data(index)
    data = @file_manager.load_game index

    @turn = data.turn
    @board = Board.new data.board

    true
  end

  def handle_load_option(option)
    return true if option == 'b'

    index = option.to_i - 1

    set_up_data index
  end

  def load_game
    puts "\nSaved games:\n"

    games = @file_manager.load_saved_games_titles

    if games.empty?
      puts 'No saved games.'

      return true
    end

    games.each_with_index { |game, index| puts "(#{index}) - #{game}" }

    option = choose_game_index games.size

    handle_load_option option
  end

  def handle_option(option)
    if option == '1'
      load_game
    elsif option == '2'
      new_game

      false
    else
      @is_running = false
    end
  end

  def main_menu
    is_maining = true

    while is_maining

      puts "(1) - load game\n(2) - new game\n(3) - terminate program (not recommended)\n"

      options = 3
      option = choose_nth options
      is_maining = handle_option option
    end
  end
end
