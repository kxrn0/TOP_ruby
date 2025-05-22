# frozen-string-literal: true

require_relative 'inputable'

# Game logic handler
class LogicHandler
  include Inputable

  def initialize(game)
    @game = game
    @is_running = true
  end

  def play
    while @is_running
      @game.board.draw

      make_move

      winner = @game.board.compute_winner

      reset unless winner.nil
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

  def act_on_choice(choice)
    is_number = choice =~ /\d/

    if is_number
      puts 'update the board'
    else
      puts 'do something else'
    end
  end

  def make_move
    valid_choice = false

    choice = make_choice until valid_choice

    act_on_choice choice
  end

  def reset
  end
end
