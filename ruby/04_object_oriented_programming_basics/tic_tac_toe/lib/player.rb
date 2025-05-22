# frozen-string-literal: true

# The player class, keeps track of name and score.
class Player
  attr_reader :name, :wins, :marker

  def initialize(marker, name)
    @marker = marker
    @name = name
    @wins = 0
  end
end
