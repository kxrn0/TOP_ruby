# frozen-string-literal: true

# Class for the board
class Board
  attr_reader :show_cell_numbers

  WINNING_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize
    @cells = Array.new 9
    @show_cell_numbers = true
  end

  def toggle_cell_numbers
    @show_cell_numbers = !@show_cell_numbers
  end

  def draw
    puts "\nboard..."
  end

  def compute_winner
    WINNING_COMBINATIONS.each do |combi|
      marker = @cells[combi[0]]
      wins = combi.all? do |idx|
        @cells[idx].nil? == false &&
          @cells[idx] == marker
      end

      return marker if wins
    end

    nil
  end

  def taken
    taken_cells = []

    @cells.each_with_index do |cell, idx|
      taken_cells.push(idx + 1) unless cell.nil?
    end

    taken_cells.map(&:to_s)
  end

  def set_cell(number, marker)
    index = number - 1
    @cells[index] = marker
  end

  def full?
    @cells.none?(&:nil?)
  end
end
