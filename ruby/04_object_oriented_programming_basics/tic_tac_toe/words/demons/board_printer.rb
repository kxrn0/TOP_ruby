# frozen-string-literal: true

# simple board class
class Board
  attr_accessor :width, :height, :cells

  def initialize(width, height)
    @width = width
    @height = height
    @cells = Array.new width * height
  end

  def to_s
    grid = ''

    @height.times do |y|
      row = build_row y
      grid += row
    end

    grid
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

  def compute_padding(number)
    longest_size = (@width * @height).to_s.size
    current_size = number.to_s.size
    diff = longest_size - current_size

    '_' * diff
  end

  def build_cell_layer3(index, row_number)
    floor_tile = row_number < @height - 1 ? '_' : ' '
    floor = floor_tile * 4
    number = index + 1
    padding = compute_padding number
    bottom = "#{padding}#{number}"

    "#{floor}#{bottom}"
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
      index = x + row_number * @width
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

width = 5
height = 4
board = Board.new width, height

cells = [
  nil, 'x', 'x', 'o', nil,
  nil, nil, 'o', 'x', 'o',
  'x', 'o', 'x', nil, nil,
  nil, nil, nil, 'o', nil
]

board.cells = cells

in_print = board.to_s

puts in_print
