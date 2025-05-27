# frozen-string-literal: true

require_relative 'inputable'

# Game logic handler
class LogicHandler
  include Inputable

  def initialize(game)
    @game = game
    @restarted_game = false
    @hard_reset = false
    @loop_make_move = true
    @is_running = true
  end

  def play
    game_loop

    return unless @hard_reset

    @game.start
  end

  def advance_to_next_round(winner)
    is_tie = winner.nil && @game.board.full?

    if is_tie
      @game.ties += 1
    else
      player = @game.players.find { |player| player.marker == marker }

      player.wins += 1
    end

    @game.round.increase

    @game.turn = @game.round.first_turn
    @game.board = Board.new
  end

  def reset
    @restarted_game = false
    @hard_reset = false
    @loop_make_move = true
    @is_running = true

    @game.turn = @game.round.first_turn
    @game.board = Board.new
  end

  private

  def change_turn
    @game.turn = 1 - @game.turn
  end

  def update
    winner = @game.board.compute_winner

    change_turn

    restart winner unless winner.nil?
  end

  def update_board(cell_number)
    return if cell_number.nil?

    marker = @game.players[@game.turn].marker
    @game.board.set_cell cell_number, marker
  end

  def perform_action(option)
    case option
    when 'h'
      @game.printer.print_help
    when 'b'
      @game.board.draw
    when 's'
      @game.printer.print_scores
    when 'c'
      @game.board.toggle_cell_numbers
    when 'r'
      @loop_make_move = false
      @restarted_game = true

      puts "\nRestarting current game!\n"
    when 'k'
      @loop_make_move = false
      @hard_reset = true

      puts 'resetting'
    when 'e'
      @loop_make_move = false
      @is_running = false

      puts "\nShuting down...\n"
    end
  end

  def act_on_option(option)
    is_number = option =~ /\d/

    if is_number
      @loop_make_move = false

      option.to_i
    else
      option = option.downcase

      perform_action option
    end
  end

  def make_choice
    name = @game.players[@game.turn].name
    prompt = "「#{name}」 > "
    error_message = 'Please enter an empty cell number or a help command!'
    options = Game.help_options
    excluded = @game.board.taken

    get_input prompt, error_message, options, excluded
  end

  def make_move
    @loop_make_move = true

    cell_number = nil

    while @loop_make_move
      input = make_choice

      cell_number = act_on_option input
    end

    update_board cell_number
  end

  def move
    @restarted_game = false

    @game.board.draw

    make_move
  end

  def restart
    puts 'restarting...'
  end

  def game_loop
    while @is_running
      move

      return unless @is_running

      if @restarted_game
        restart
      elsif @hard_reset
        @is_running = false
      else
        update
      end
    end
  end
end
