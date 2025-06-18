# frozen-string-literal: true

require_relative 'coder'
require_relative 'game'

# Handles the input of a Game object
class InputHandler
  COMMANDS =
    ['!n', '!s', '!c', '!h', '!e']
    .freeze

  def initialize(game)
    @game = game
  end

  def print_prompt
    puts "\n#{@game.coder.hints_to_s}\n"
    puts "\n#{@game.coder.keyboard_to_s}\n"
    print "(#{@game.player.lives} / #{Coder::MAX_MISTAKES}) > "
  end

  def handle_input
    print_prompt

    input = gets.chomp.downcase

    redirect input
  end

  def answer_yes_no(prompt)
    loop do
      print prompt
      input = gets.chomp.downcase.strip
      result = select_yes_no input

      return result[:answer] if result[:done]

      puts 'Please enter `yes` or `no`!'
    end
  end

  private

  def load_game(position)
    game = @game.file_manager.load_game_at(position)

    @game.load_data game
  end

  def delete_game(position)
    filename = @game.file_manager.delete_game position

    puts "Deleted game: #{filename}"
  rescue StandardError
    puts "Couldn't delete game!"
  end

  def enter_game_name
    print 'Save game with name > '

    loop do
      input = gets.chomp.strip

      return input unless input == ''

      puts 'Please enter a valid name!'
    end
  end

  def build_hash
    name = enter_game_name
    data = @game.to_h

    data[:name] = name
    data[:created_at] = Time.now.to_i

    data
  end

  def obey(command)
    case command
    when '!n'
      @game.new_game
    when '!s'
      @game.file_manager.show_games
    when '!c'
      @game.file_manager.save_game build_hash
    when '!h'
      puts Game::HELP
    when '!e'
      @game.terminate
    end
  end

  def extract_index(command)
    reg = /![ld]\s(\d+)/
    match = reg.match command
    index = match.captures[0]

    index.to_i
  end

  def execute(command)
    loareg = /!l\s\d+/
    delreg = /!d\s\d+/

    if loareg.match? command
      load_game extract_index command
    elsif delreg.match? command
      delete_game extract_index command
    else
      obey command
    end
  end

  def select_yes_no(input)
    done = %w[yes no].include?(input)

    { done: done, answer: input == 'yes' }
  end

  def redirect(input)
    reg = /^![ld]\s\d+$/
    is_command = (COMMANDS.include? input) || (reg.match? input)

    if is_command
      execute input
    elsif @game.coder.available.include? input
      @game.make input
    else
      puts "\nPlease enter a valid input!"
    end
  end
end
