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
    @width = 3
    @height = 3
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

  def to_s
    grid = ''

    @height.times do |y|
      row = build_row y
      grid += row
    end

    grid
  end

  def draw_self
    puts "\n#{self}"
  end

  private

  def build_cell_layer1
    ' ' * 5
  end

  def build_cell_layer2(index)
    value = @cells[index]
    marker = value.nil? ? ' ' : value
    spaces = ' ' * 2

    "#{spaces}#{marker}#{spaces}"
  end

  def build_cell_layer3(index, row_number)
    floor_tile = row_number < @height - 1 ? '_' : ' '
    floor = floor_tile * 4

    "#{floor}#{index + 1}"
  end

  def build_cell_layer(layer_number, index, row_number)
    case layer_number
    when 1
      build_cell_layer1
    when 2
      build_cell_layer2 index
    when 3
      build_cell_layer3 index, row_number
    end
  end

  def build_cell(layer_number, index, col_number, row_number)
    cell = build_cell_layer layer_number, index, row_number
    wall = col_number == @width - 1 ? '' : '|'

    cell + wall
  end

  def build_layer(layer_index, row_number)
    layer_number = layer_index + 1
    layer = ''

    @width.times do |x|
      index = x + (row_number * @width)
      layer += build_cell layer_number, index, x, row_number
    end

    layer
  end

  def build_row(row_number)
    row = ''
    layers = 3

    layers.times do |l|
      layer = build_layer l, row_number

      row += "#{layer}\n"
    end

    row
  end
end
