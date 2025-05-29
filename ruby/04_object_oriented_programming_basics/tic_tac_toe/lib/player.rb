# frozen_string_literal: true

# player class
class Player
  attr_accessor :wins
  attr_reader :marker

  def initialize(marker)
    @marker = marker
    @wins = 0
  end
end
