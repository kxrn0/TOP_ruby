# frozen-string-literal: true

# The player class, keeps track of name and score.
class Player
  attr_accessor :wins
  attr_reader :name, :marker

  def initialize(marker, name)
    @marker = marker
    @name = name
    @wins = 0
  end
end
