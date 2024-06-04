require_relative "./point"

def get_moves(cell, size)
  points = [
    Point.new(-2, -1),
    Point.new(-1, -2),
    Point.new(1, -2),
    Point.new(2, -1),
    Point.new(2, 1),
    Point.new(1, 2),
    Point.new(-1, 2),
    Point.new(-2, 1),
  ]
  moves = []
  downsize = size - 1

  points.each do |move|
    move = Point.new move.x + cell.x, move.y + cell.y

    if move.x.between?(0, downsize) && move.y.between?(0, downsize)
      moves.push move
    end
  end

  moves
end
