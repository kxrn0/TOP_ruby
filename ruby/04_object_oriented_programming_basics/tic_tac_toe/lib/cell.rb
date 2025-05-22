# frozen-string-literal: true

# Class for a cell on the board
class Cell
  def initialize(number, marker)
    @number = number
    @marker = marker
  end

  def empty
    @marker.nil?
  end
end
