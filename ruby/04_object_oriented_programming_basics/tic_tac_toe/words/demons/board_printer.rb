# frozen-string-literal: true

# simple board class
class Board
  attr_accessor :width, :height, :cells

  def initialize(width, height)
    @width = width
    @height = height
    @cells = Array.new width * height
    @show_cell_numbers = true
  end

  def toggle_cell_numbers
    @show_cell_numbers = !show_cell_number
  end

  def print_board
    bostr = ''

    @height.times do |y|
      @width.times do |x|
        cell = print_cell x, y
        bostr += cell.chomp
      end

      bostr += "\n"
    end

    bostr
  end

  private

  def print_cell(x, y)
    wall = x < @width - 1 ? '|' : ''
    floor = y < @height - 1 ? '_' : ''
    index = x + y * @width
    value = @cells[index]
    marker = value.nil? ? ' ' : value
    number = @show_numbers ? index + 1 : '_'

    <<~HEREDOC
           #{wall}
        #{marker}  #{wall}
      #{floor * 4}#{number}#{wall}
    HEREDOC
  end
end

width = 5
height = 6
board = Board.new width, height

cells = [
  nil, 'x', 'x', 'o', nil,
  nil, nil, 'o', 'x', 'o',
  'x', 'o', 'x', nil, nil,
  nil, nil, nil, 'o', nil
]

board.cells = cells

in_print = board.print_board

puts in_print
