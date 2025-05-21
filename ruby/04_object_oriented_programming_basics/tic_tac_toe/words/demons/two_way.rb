# frozen-string-literal: true

# player class
class Player
  def initialize(name, game)
    @name = name
    @game = game
  end

  def foo
    puts @game.score
  end
end

# game class
class Game
  attr_reader :score

  def initialize
    @score = 10
    @player = Player.new 'anon', self
  end

  def fun
    @player.foo
  end
end

game = Game.new

game.fun
