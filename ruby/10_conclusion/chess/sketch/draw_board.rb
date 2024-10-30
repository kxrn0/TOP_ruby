def draw_section(rank, is_padding)
  white_blank = "□"
  black_blank = "■"
  str = ""

  rank.each do |square|
    color = square.color == "white" ? white_blank : black_blank
    piece = color

    if square.piece && !is_padding
      white_pieces = { "king" => "♔", "queen" => "♕", "rook" => "♖", "bishop" => "♗", "knight" => "♘", "pawn" => "♙" }
      black_pieces = { "king" => "♚", "queen" => "♛", "rook" => "♜", "bishop" => "♝", "knight" => "♞", "pawn" => "♟" }
      set = nil

      if square.piece.color == "white"
        set = white_pieces
      else
        set = black_pieces
      end

      piece = set[square.piece.type]
    end

    str += "#{color} #{piece} #{color} "
  end

  str
end

def draw_rank(rank)
  padding = draw_section rank, true
  middle = draw_section rank, false

  "#{padding}\n#{middle}\n#{padding}\n"
end

def draw_board(board, perspective)
  if perspective == "black"
    board = board.reverse

    board.size.times do |index|
      board[index] = board[index].reverse
    end
  end

  str = ""

  board.each do |rank|
    str += draw_rank rank
  end

  str
end

class Square
  attr_accessor :piece
  attr_reader :color

  def initialize(color, piece = nil)
    @color = color
    @piece = piece
  end
end

class Piece
  attr_reader :type, :color

  def initialize(type, color)
    @type = type
    @color = color
  end
end

default = [
  [
    Square.new("white", Piece.new("rook", "black")),
    Square.new("black", Piece.new("knight", "black")),
    Square.new("white", Piece.new("bishop", "black")),
    Square.new("black", Piece.new("queen", "black")),
    Square.new("white", Piece.new("king", "black")),
    Square.new("black", Piece.new("bishop", "black")),
    Square.new("white", Piece.new("knight", "black")),
    Square.new("black", Piece.new("rook", "black")),
  ],
  [
    Square.new("black", Piece.new("pawn", "black")),
    Square.new("white", Piece.new("pawn", "black")),
    Square.new("black", Piece.new("pawn", "black")),
    Square.new("white", Piece.new("pawn", "black")),
    Square.new("black", Piece.new("pawn", "black")),
    Square.new("white", Piece.new("pawn", "black")),
    Square.new("black", Piece.new("pawn", "black")),
    Square.new("white", Piece.new("pawn", "black")),
  ],
  [
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
  ],
  [
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
  ],
  [
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
  ],
  [
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
  ],
  [
    Square.new("white", Piece.new("pawn", "white")),
    Square.new("black", Piece.new("pawn", "white")),
    Square.new("white", Piece.new("pawn", "white")),
    Square.new("black", Piece.new("pawn", "white")),
    Square.new("white", Piece.new("pawn", "white")),
    Square.new("black", Piece.new("pawn", "white")),
    Square.new("white", Piece.new("pawn", "white")),
    Square.new("black", Piece.new("pawn", "white")),
  ],
  [
    Square.new("black", Piece.new("rook", "white")),
    Square.new("white", Piece.new("knight", "white")),
    Square.new("black", Piece.new("bishop", "white")),
    Square.new("white", Piece.new("queen", "white")),
    Square.new("black", Piece.new("king", "white")),
    Square.new("white", Piece.new("bishop", "white")),
    Square.new("black", Piece.new("knight", "white")),
    Square.new("white", Piece.new("rook", "white")),
  ],
]

game_one = [
  [
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
  ],
  [
    Square.new("black", Piece.new("pawn", "black")),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white", Piece.new("pawn", "black")),
    Square.new("black"),
    Square.new("white", Piece.new("pawn", "black")),
  ],
  [
    Square.new("white"),
    Square.new("black", Piece.new("pawn", "black")),
    Square.new("white"),
    Square.new("black", Piece.new("bishop", "black")),
    Square.new("white", Piece.new("pawn", "black")),
    Square.new("black"),
    Square.new("white", Piece.new("king", "black")),
    Square.new("black"),
  ],
  [
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white", Piece.new("pawn", "black")),
    Square.new("black"),
    Square.new("white"),
  ],
  [
    Square.new("white"),
    Square.new("black"),
    Square.new("white", Piece.new("pawn", "white")),
    Square.new("black"),
    Square.new("white", Piece.new("queen", "black")),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
  ],
  [
    Square.new("black"),
    Square.new("white", Piece.new("pawn", "white")),
    Square.new("black"),
    Square.new("white", Piece.new("knight", "white")),
    Square.new("black"),
    Square.new("white"),
    Square.new("black", Piece.new("pawn", "white")),
    Square.new("white", Piece.new("king", "white")),
  ],
  [
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
    Square.new("black", Piece.new("pawn", "white")),
  ],
  [
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white", Piece.new("queen", "white")),
    Square.new("black"),
    Square.new("white"),
    Square.new("black"),
    Square.new("white"),
  ],
]

puts draw_board game_one, "black"

# puts draw_board default, "white"
# puts "-----------"
# puts draw_board default, "black"
