# frozen-string-literal: true

# Game round
class Round
  attr_accessor :number, :first_turn

  def initialize(number, first_turn)
    @number = number
    @first_turn = first_turn
  end

  def advance
    @number += 1
    @first_turn = 1 - @first_turn
  end
end
