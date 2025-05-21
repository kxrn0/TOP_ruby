# frozen-string-literal: true

# The player class, keeps track of name and score.
class Player
  def initialize(marker, name)
    @marker = marker
    @name = name
    @wins = 0
    @loses = 0
  end
end
