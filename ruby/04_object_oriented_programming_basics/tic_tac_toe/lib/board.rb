# frozen_string_literal: true

# it keeps track of the board state,
# and has some board methods
class Board
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
  end

  def draw
    puts "
       |     |
      #{@cells[0]} |  #{@cells[1]}   |  #{@cells[2]}
      0|    1|    2
  -----.-----.-----
       |     |
      #{@cells[3]} |  #{@cells[4]}   |  #{@cells[5]}
      3|    4|    5
  -----.-----.-----
       |     |
      #{@cells[6]} |  #{@cells[7]}   |  #{@cells[8]}
      6|    7|    8
  "
  end

  def full?
    @cells.none?(&:nil?)
  end

  def taken
    numbers = []

    @cells.each_with_index do |value, index|
      numbers.push (index + 1).to_s unless value.nil?
    end

    numbers
  end

  def set(cell_number, marker)
    index = cell_number.to_i - 1
    @cells[index] = marker
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
end
