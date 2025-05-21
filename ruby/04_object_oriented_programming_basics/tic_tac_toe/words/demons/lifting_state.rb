# frozen-string-literal: true

# Initializes the game
module GameInitializable
  def build_game
    @x = 10
  end
end

# Handles the game logic
module GameLogickable
  def loop_game
    @x += 1

    puts "playing, x: #{@x}"
  end
end

# Oversees the workings of the game
class Game
  include GameInitializable
  include GameLogickable

  def initialize
    @x = nil
  end

  def start
    build_game

    puts "game built, x: #{@x}"

    loop_game
  end
end

game = Game.new

game.start
