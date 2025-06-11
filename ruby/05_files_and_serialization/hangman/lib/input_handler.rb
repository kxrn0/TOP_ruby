# frozen-string-literal: true

require_relative 'game'

# Handles the input of a Game object
class InputHandler
  COMMANDS =
    ['!n', '!s', '!c', '!h', '!e']
    .freeze

  def initialize(game)
    @game = game
  end

  def handle_input
    print '> '

    input = gets.chomp.downcase

    redirect input
  end

  private

  def load_game(command)
    index = (command.split ' '[1]).to_i
  end

  def delete_game(command)
  end

  def obey(command)
    case command
    when '!n'
      new_game
    when '!s'
      show_games
    when '!c'
      save_game
    when '!h'
      print_help
    when '!e'
      terminate
    end
  end

  def execute(command)
    loareg = /!l\s\d+/
    delreg = /!d\s\d+/

    if loareg.match? command
      load_game command
    elsif delreg.match? command
      delete_game command
    else
      obey command
    end
  end

  def make(move)
    hit = @game.coder.guess move

    @game.player.lives -= 1 unless hit
  end

  def redirect?(input)
    reg = /^![ld]\s\d+$/
    is_command = (COMMANDS.include? input) || (reg.match? input)

    if is_command
      execute input
    elsif @game.coder.available.include? input
      make input
    end
  end
end
