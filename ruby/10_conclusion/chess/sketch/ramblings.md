## draw_chessboard

This method will probably differ from the method we'll use in the game to draw the chessboard, but we'll probably use some of the core functionality in both.

The board will be represented as a 2D array, with each nested array being a rank. A null value in a rank array represents an empty square, and a hash represents an occupied one. A hash has two fields; player, and piece. The player is either "b" or "w", and the pieces have the following mappings

```
"p" -> pawn
"r" -> rook
"n" -> knight
"b" -> bishop
"q" -> queen
"k" -> king
```

The orientation of the board will depend on who's turn it is. The board is stored in such a way that the first rank is 8, but if we want to print the board from black's perspective, we'd have to print 1 first. So the method will be somethig like

```ruby
def draw_board(state, turn)
  if turn == "black"
    state = state.reverse
  end

  str = ""

  state.each_with_index do |rank, rank_index|
    rank.each_with_index do |square, square_index|
      # rest of the fucking...
    end
    str += "\n"
  end
end

```

What do I do about colors? a black character on black background may be impossible to make out. I really shouldn't think too much about it; I'll use black and white for the colors of the pieces, and red and green for the colors of the board. Red corresponds to black, and white corresponds to green.

After playing around with ANSI escape color codes I think I'll have to "build" each representation of a piece on the board. The white pieces are just and outline of the black ones, so they may be harder to see, but I can paint the black pieces whatever color I want, so I can just use the black pieces and paint them white whenever I need a white one.

When painting a piece if I don't specify the background color, it seems to stay transparent, which makes black pieces in a black background hard to see. So the piece will be constructed by looking at what color the square the piece is in, and setting the background of the piece appropriately.

Each checkboard square will be composed of empty spaces painted their respective color. In the case of white squares, they will be painted green, which means they will be built from the string `"\e[101m \e[0m"`, while black squares will be red, which means they'll be made from the string `"\e[42m \e[0m"`. The background of the piece will depend on which square it is in. Now we need to find a way to tell the color of the square we are in.

I'll use a number to decide what color to paint a square. 0 = white, 1 = black.
There will be two loops; an outer one iterating for each rank, and an inner one going through each square in that rank. Rather than a number, I could use a boolean; `is_white = true`. The variable is set in the outer loop before iterating each rank:

```ruby
board = [
  [0, 1, 2, 3],
  [4, 5, 6, 7],
  [8, 9, 10, 11],
  [12, 13, 14, 15]
]

board.each_with_index do |rank, rank_index|
  is_white = rank_index.even?

  rank.each do |value|
    color = is_white ? "white" : "black"

    puts color

    is_white = !is_white
  end
  puts "- - - -"
end
```

Now I know what color the square I'm on is. To build the string that represents the board I will need to think a bit harder. A rank in the string looks like

```
gggrrrgggrrrgggrrrgggrrr
g♞grrrgggrrrgggr♝rg♛grrr
gggrrrgggrrrgggrrrgggrrr
```

where g is a blank white spot, and r is a blank red spot, so

```
ggg
g♛g
ggg
```

is a white square with a black queen on it. So to build a rank I will have to do something like

```ruby
def draw_board state
  str = ""

  state.each_with_index do |rank, index|
    is_white = index.even?

    # draw the top of the rank
    # draw the middle of the rank
    # draw the bottom of the rank
  end
end
```

The top and bottom of the rank sound easy, they are the same actually. I could even use a different method to manufacture them.

```ruby
def draw_padding width, is_white
  white_blank = "\e[42m \e[0m"
  black_blank = "\e[101m \e[0m"
  str = ""
  width.times do
    color = is_white ? white_blank : black_blank

    str += color * 3

    is_white = !is_white
  end
  str += "\n"
end
```

where width is the number of columns in the board, which tends to be eight in chess. The variables `white_blank` and `black_blank` will probably be class variables rather than being defined in the `draw_padding` function itself, and they will probably consist of three spaces rather than one, since with one space only the board would look very vertically stretched. It also looks stretched with three spaces, but not as much. It's a matter of taste, and I think it looks better horizontally stretched.

How do we draw the middle of the rank? it would be similar to the function above, but first, what is a square? what is a piece? do I need to create a class for the pieces? I think for some moves like castling and en passe someone has to keep track of moves the pieces have made, so a class for the pieces makes sense. Should I make a class for the squares? What would a square class contain? The function I'm writting now relies on ANSI codes to do its job, but I said its purpose would be to print boards for this document, which can't render the codes.

Let's go back and fix this. We'll use ■ for a black square and □ for a white one.

Let's make a square class

```ruby
class Square
  attr_accessor :piece
  attr_reader :color

  def initialize color, piece = nil
    @color = color
    @piece = piece
  end
end
```

where `piece` is an instance of

```ruby
class Piece
  attr_reader :type, :color

  def initialize type, color
    @type = type
    @color = color
  end
end
```

and color is `"black"` or `"white"`.

The board object will construct the board and give each square the correct color and piece.

Then the function to draw the padding looks like this

```ruby
def draw_padding rank
  white_blank = "□"
  black_blank = "■"
  str = ""

  rank.each do |square|
    color = square.color == "white" ? white_blank : black_blank

    str += "#{"#{color} " * 3}"
  end

  str += "\n"
end
```

With this, the following code

```
rank = [
  Square.new("white", Piece.new("pawn", "white")),
  Square.new("black", Piece.new("rook", "white")),
  Square.new("white", Piece.new("bishop", "black")),
  Square.new("black", Piece.new("queen", "black")),
  Square.new("white", Piece.new("knight", "white")),
  Square.new("black", Piece.new("king", "white")),
  Square.new("white", Piece.new("rook", "black")),
  Square.new("black", Piece.new("pawn", "black")),
]

puts draw_padding rank
```

would output

```
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
```

The function that prints the middle of the square would be very similar. It would print six characters side by side, three of them being spaces like above.
If we ignore spaces we can say that for each iteration three characters are added to the string; two blank squares to the side, and the character in the middle. If the square is empty, this character is a blank the same as the other two, otherwise is a character representing the piece that is in that square.

```ruby
def draw_middle rank
  white_pieces = {"king" => "♔", "queen" => "♕", "rook" => "♖", "bishop" => "♗", "knight" => "♘", "pawn" => "♙"}
  black_pieces = {"king" => "♚", "queen" => "♛", "rook" => "♜", "bishop" => "♝", "knight" => "♞", "pawn" => "♟"}
  white_blank = "□"
  black_blank = "■"
  str = ""

  rank.each do |square|
    color = square.color == "white" ? white_blank : black_blank
    piece = color

    if square.piece
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
```

The following code

```ruby
def draw_middle rank
  # rest of the fucking...
end

rank = [
  Square.new("white", Piece.new("pawn", "white")),
  Square.new("black", Piece.new("rook", "white")),
  Square.new("white", Piece.new("bishop", "black")),
  Square.new("black", Piece.new("queen", "black")),
  Square.new("white", Piece.new("knight", "white")),
  Square.new("black", Piece.new("king", "white")),
  Square.new("white", Piece.new("rook", "black")),
  Square.new("black", Piece.new("pawn", "black")),
]

puts draw_middle rank
```

outputs

```
□ ♙ □ ■ ♖ ■ □ ♝ □ ■ ♛ ■ □ ♘ □ ■ ♔ ■ □ ♜ □ ■ ♟ ■
```

and if we combine them

```ruby
def draw_rank rank
  padding = draw_padding rank
  middle = draw_middle rank

  "#{padding}\n#{middle}\n#{padding}\n"
end
```

with the input above would yield

```
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ ♙ □ ■ ♖ ■ □ ♝ □ ■ ♛ ■ □ ♘ □ ■ ♔ ■ □ ♜ □ ■ ♟ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
```

Putting it all toghether and changing things a bit we get

```ruby
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
```
