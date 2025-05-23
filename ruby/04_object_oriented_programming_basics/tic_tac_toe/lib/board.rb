# frozen-string-literal: true

# Class for the board
class Board
  def initialize
    @cells = Array.new 9
    @show_cell_numbers = true
  end

  def toggle_cell_numbers
    @show_cell_numbers = !@show_cell_numbers
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

  def set_cell(number, marker)
    index = number - 1
    @cells[index] = marker
  end

  def board_full?
    @cells.none?(&:nil?)
  end
end
