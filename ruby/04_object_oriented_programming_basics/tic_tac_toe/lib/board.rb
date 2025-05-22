# frozen-string-literal: true

# Class for the board
class Board
  def initialize
    @cells = Array.new 9
  end

  def draw
    puts 'board...'
  end

  def compute_winner
    @board[0]
  end

  def taken
    taken_cells = []

    @cells.each_with_index { |cell, idx| taken_cells.push idx unless cell.nil? }

    taken_cells
  end
end
