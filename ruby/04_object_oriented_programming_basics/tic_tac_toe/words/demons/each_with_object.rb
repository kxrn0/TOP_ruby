# frozen-string-literal: true

# The cell
class Cell
  attr_reader :number

  def initialize(number, empty)
    @number = number
    @empty = empty
  end

  def empty?
    @empty
  end
end

# The board
class Board
  def initialize
    # 0 1 1
    # 1 1 0
    # 0 0 1
    #
    # [2, 3, 4, 5, 9]
    @cells = [
      Cell.new(1, false), Cell.new(2, true), Cell.new(3, true),
      Cell.new(4, true), Cell.new(5, true), Cell.new(6, false),
      Cell.new(7, false), Cell.new(8, false), Cell.new(9, true)
    ]
  end

  def find_empty_cells
    @cells.each_with_object([]) do |cell, numbers|
      numbers.push cell.number if cell.empty?
    end
  end
end

board = Board.new

puts board.find_empty_cells
