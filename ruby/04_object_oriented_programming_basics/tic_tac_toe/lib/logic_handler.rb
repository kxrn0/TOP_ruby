# frozen-string-literal: true

require_relative 'inputable'

# Game logic handler
class LogicHandler
  include Inputable

  def initialize(game)
    @game = game
    @restarted_game = false
    @loop_make_move = true
  end

  def move
    @restarted_game = false

    @game.board.draw

    make_move
  end

  def update
    winner = @game.board.compute_winner

    reset unless winner.nil?
  end

  def play
    while @game.is_running

      move

      if @restarted_game
        restart
      else
        update
      end
    end
  end

  private

  def make_choice
    name = @game.player.name
    prompt = "「#{name}」 > "
    error_message = 'Please enter an empty cell number or a help command!'
    options = Game.help_options
    excluded = @game.board.taken

    get_input prompt, error_message, options, excluded
  end

  def update_board(cell_number)
    return if cell_number.nil?

    marker = @game.players[@turn].marker
    @game.board.set_cell cell_number, marker
  end

  def perform_action(option)
    case option
    when 'h'
      puts 'help...'
    when 'b'
    when 's'
    when 'c'
    when 'r'
    when 'k'
    when 'e'
    end
  end

  def act_on_option(option)
    is_number = option =~ /\d/

    if is_number
      option.to_i
    else
      input = input.downcase

      perform_action input
    end
  end

  def make_move
    @loop_make_move = true

    cell_number = nil

    while @loop_make_move
      input = make_choice

      cell_number = act_on_option input
      @loop_make_move = cell_number.nil?
    end

    update_board cell_number
  end

  def reset
  end
end
