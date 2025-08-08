# frozen_string_literal: true

require_relative 'inputable'

# Handles game logic
class GameLogicHandler
  include Inputable

  def initialize(game)
    @game = game
    @is_gaming = true
  end

  def game_loop
    @is_gaming = true

    while @is_gaming
      @game.board.draw

      input = make_move

      update_state input
    end
  end

  private

  def input_choice
    name = @game.current_name
    prompt = "「#{name}」> "
    test = proc { |input| /^([1-7]|exit)$/i.match? input }
    error_message = 'Invalid column number!'

    get_input(prompt, test, error_message).downcase
  end

  def handle_input(choice)
    return choice if choice == 'exit'

    column = choice.to_i

    column unless @game.board.column_full? column
  end

  def make_move
    loop do
      choice = input_choice
      result = handle_input choice

      return result unless result.nil?

      puts 'Column full!'
    end
  end

  def update_state(input)
    if input == 'exit'
      terminate
    else
      update input
    end
  end

  def update(column)
    @game.board.update column, @game.current_name

    winner = @game.board.winner

    if winner
      game_over winner
    elsif @game.board.full?
      game_over
    else
      switch_turn
    end
  end

  def terminate
    @is_gaming = false
    @game.is_running = false
  end

  def game_over(winner = nil)
    puts "\n=== GAME OVER! ==="

    @game.board.draw

    @is_gaming = false

    if winner.nil?
      puts "it's a tie!"
    else
      puts "「#{@game.current_name}」 wins!"
    end

    puts "\n"
  end

  def switch_turn
    @game.turn = 1 - @game.turn
  end
end
