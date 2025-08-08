# frozen_string_literal: true

# Board
class Board
  WIDTH = 7
  DEPTH = 6
  WIN_SIZE = 4

  def initialize
    @columns = []

    WIDTH.times do
      @columns << Array.new(DEPTH)
    end
  end

  def draw
    puts "\n#{self}\n"
  end

  def to_s
    str = ''

    @columns.size.times { |n| str += "#{n + 1} " }
    str += "\n"
    DEPTH.times { |r| str += row_to_s r }

    str
  end

  def column_full?(column)
    @columns[column - 1].none?(&:nil?)
  end

  def full?
    @columns.all? { |col| col.none?(&:nil?) }
  end

  def winner
    DEPTH.times do |row|
      WIDTH.times do |col|
        result = check_cell row, col

        return result unless result.nil?
      end
    end

    nil
  end

  def update(column, piece)
    col_index = column - 1
    column = @columns[col_index]
    index = get_top_index column

    column[index] = piece
  end

  private

  def row_to_s(row)
    strow = ''

    @columns.each do |col|
      char = col[row].nil? ? '_' : col[row]

      strow += "#{char} "
    end

    strow += "\n"

    strow
  end

  def check_cell(row, col)
    piece = at row, col
    won = check_line(row, col, 1, 0) ||
          check_line(row, col, 0, 1) ||
          check_line(row, col, 1, 1) ||
          check_line(row, col, 1, -1)

    piece if won
  end

  def check_line(row, col, p_row, p_col)
    piece = at row, col

    WIN_SIZE.times do |i|
      r = row + (i * p_row)
      c = col + (i * p_col)
      current = at r, c

      return nil unless current == piece
    end

    piece
  end

  def get_top_index(column)
    index = nil

    column.each_index do |idx|
      unless column[idx].nil?
        index = idx - 1
        break
      end
    end

    index = column.size - 1 if index.nil?

    index
  end

  def at(row, col)
    return unless row.between?(0, DEPTH - 1) && col.between?(0, WIDTH - 1)

    umn = @columns[col]

    return if umn.nil?

    umn[row]
  end
end
