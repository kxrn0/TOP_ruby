# frozen-string-literal: true

require_relative 'coder'

# Represents a player
class Player
  attr_accessor :lives

  def hydrate(data)
    @lives = data['lives']
  end

  def initialize
    @lives = Coder::MAX_MISTAKES
  end

  def to_h
    { lives: @lives }
  end
end
