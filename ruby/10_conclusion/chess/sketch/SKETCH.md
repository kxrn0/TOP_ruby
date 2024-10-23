# Chess

## Overview

How will the game work? Can we correctly display colors in the terminal? echoing the black king ♚ on my terminal prints it with a light color, since the color scheke is dark, so it could be confusing. There's the colorize gem, which uses color to colorize non colorized stuff. I'll see if I can figure out how to use it, so for now I'll assume that I can draw the characters the correct color regardless of the terminal theme.

Let's make this simple. There will be two players; white and black. According to the rules of chess white goes first, but I guess that implies that who is white and who is black is decided randomly, so before the game we will ask the players for their names, and randomly assign them colors. It will look like this

```
Chess.
Copyright kxrn0 1987

Enter the name of the first player > Bob
Enter the name of the second player > Alice

Alice will be white ♙
Bob will be black ♟

Alice goes first. Press Enter to continue.
```

After this the screen will be cleared and the game will start. Before we continue let's implement a `draw_chessboard` function, since we will need to draw many chessboards in this document.

### draw_chessboard

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
