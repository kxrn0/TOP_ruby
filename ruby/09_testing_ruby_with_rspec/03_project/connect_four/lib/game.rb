# frozen_string_literal: true

require_relative 'player'
require_relative 'game_state_handler'
require_relative 'game_logic_handler'

# Game
class Game
  attr_accessor :board, :turn, :is_running
  attr_reader :players

  def initialize
    @state_handler = GameStateHandler.new self
    @logic_handler = GameLogicHandler.new self
    @board = nil
    @players = [Player.new('x'), Player.new('o')]
    @turn = nil
    @is_running = true
  end

  def run
    while @is_running
      @state_handler.set_up
      @logic_handler.game_loop
      @state_handler.play_again
    end
  end

  def current_name
    @players[@turn].name
  end
end
