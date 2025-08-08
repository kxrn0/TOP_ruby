# Chess

## Sketch

To keep things simple I'll use these symbols for the pieces.

```
x.H.x x.P.x x.A.x x.Q.x x.K.x x.i.x
o.H.o o.P.o o.A.o o.Q.o o.K.o o.i.o
```

the board will look like this

```
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
8 - x.H.x - # x.P.x # - x.A.x - # x.Q.x # - x.K.x - # x.A.X # - x.P.x - # x.H.x #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
7 # x.i.x # - x.i.x - # x.i.x # - x.i.x - # x.i.x # - x.i.x - # x.i.x # - x.i.x -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
6 - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
5 # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
4 - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
3 # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
2 - o.i.o - # o.i.o # - o.i.o - # o.i.o # - o.i.o - # o.i.o # - o.i.o - # o.i.o #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
1 # o.H.o # - o.P.o - # o.A.o # - o.Q.o - # o.K.o # - o.A.o - # o.P.o # - o.H.o -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
      a         b         c         d         e         f         g         h
```

There will be two players, `x` and `o`, they can enter moves with algebraic notation.

```
o > e2-e3
```

The players can enter other commands during the game, like `save`, or `exit`.

### Start menu

```
the amazing...
CHESS!
copyright @kxrn0, 1956

(1) - load game
(2) - new game
(3) - terminate program (not recommended)

> 4

Please enter a valid option!

>
```

#### `(1) - load game`

```
> 1

Saved games:

(b) - back to main menu
(1) - first game, 1990-10-21 12:23:45
(2) - second game, 1987-02-12 01:14:17

> b

(1) - load game
(2) - new game
(3) - terminate program (not recommended)

> 1

Saved games:

(b) - back to main menu
(1) - first game, 1990-10-21 12:23:45
(2) - second game, 1987-02-12 01:14:17

> 3

No such game!

> 2
```

#### `new game`

```
Who goes first?

(1) - x
(2) - o
(3) - random

> me

Please enter a valid option!

> 2
```

### Gameplay

Whether the user starts a new game, or loads an old one, they will see the same thing. Below we assume they started a new game.

```
Instructions: Enter a move in algebraic notation as <from>-<to>, for example c4-c5.

For en-passant and castling tell the pawn or king where to move.

Further options:

(s) - Save current game
(e) - exit current game
(g) - give up current game

o goes first

  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
8 - x.H.x - # x.P.x # - x.A.x - # x.Q.x # - x.K.x - # x.A.X # - x.P.x - # x.H.x #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
7 # x.i.x # - x.i.x - # x.i.x # - x.i.x - # x.i.x # - x.i.x - # x.i.x # - x.i.x -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
6 - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
5 # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
4 - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
3 # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
2 - o.i.o - # o.i.o # - o.i.o - # o.i.o # - o.i.o - # o.i.o # - o.i.o - # o.i.o #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
1 # o.H.o # - o.P.o - # o.A.o # - o.Q.o - # o.K.o # - o.A.o - # o.P.o # - o.H.o -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
      a         b         c         d         e         f         g         h

o > g1-f3

  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
1 - o.H.o - # # # # # - o.A.o - # o.K.o # - o.Q.o - # o.A.o # - o.P.o - # o.H.o #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
2 # o.i.o # - o.i.o - # o.i.o # - o.i.o - # o.i.o # - o.i.o - # o.i.o # - o.i.o -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
3 - - - - - # # # # # - o.P.o - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
4 # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
5 - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
6 # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
7 - x.i.x - # x.i.x # - x.i.x - # x.i.x # - x.i.x - # x.i.x # - x.i.x - # x.i.x #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # #
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
8 # x.H.x # - x.P.x - # x.A.x # - x.K.x - # x.Q.x # - x.A.x - # x.P.x # - x.H.x -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
  # # # # # - - - - - # # # # # - - - - - # # # # # - - - - - # # # # # - - - - -
      h         g         f         e         d         c         b         a

x >
```

When there's a check it will be announced, and when there's a checkmate the checkmating player is announced to be the winner, and the game is ended.

## Architecture

There will be a `Chess` object that will take care of the overall details. It prints the welcome message, and the initial menu when the program is started. It will also hold the state of the game; the `Player` objects, the `Board`, and the current turn. Then there will be a `LogicHandler` that will take care of the game details. It handles input from the players, and updates the state of the game.

The board will hold the `Piece` objects. When a player wants to move a piece we

- check that there's a piece in the square the player wants to move from
- check that the piece belongs to this player
- check that there's no piece of this user in the target square
- check that the piece can actually move there
- if there's an enemy piece, remove it
- move the piece to the target square
  How do I know that a piece belongs to a player? it has its id. A piece is an object with a `owner_id` property that indicates which player owns it.

How is a `Board` instance created? It has to be given the ids of the players. I want to say that I want to make this generic, so the id could be anything, and so the pieces, but I'd like to keep this project simple, so I think it would be better to hardcode things.

White pieces will be

```
o.H.o o.P.o o.A.o o.Q.o o.K.o o.i.o
```

and black ones will be

```
x.H.x x.P.x x.A.x x.Q.x x.K.x x.i.x
```

so the id for white is `o`, and that for black is `x`. How is the board arranged in memory? I want to store it as an array of arrays where each array is a rank of the board. If I want the layout to look like from white's perspective, then the first row will be the 8th row, and the columns will be labeled from a to h. The actual labels don't matter, I could make them something else, and it should not change how it works.

I think cells should be objects themselves.

```
class Board {
  constructor(rows) {
    return this.rows = rows unless rows.null?

    b = Player::BLACK
    w = Player::WHITE

    this.rows = [
      [
        new Square(new AlCoord('a', 8), new Tower b),
        new Square(new AlCoord('b', 8), new Horse b),
        new Square(new AlCoord('c', 8), new Bishop b),
        new Square(new AlCoord('d', 8), new Queen b),
        new Square(new AlCoord('e', 8), new King b),
        new Square(new AlCoord('f', 8), new Bishop b),
        new Square(new AlCoord('g', 8), new Horse b),
        new Square(new AlCoord('h', 8), new Tower b),
      ],
      [
        new Square(new AlCoord('a', 7), new Pawn b),
        new Square(new AlCoord('b', 7), new Pawn b),
        new Square(new AlCoord('c', 7), new Pawn b),
        new Square(new AlCoord('d', 7), new Pawn b),
        new Square(new AlCoord('e', 7), new Pawn b),
        new Square(new AlCoord('f', 7), new Pawn b),
        new Square(new AlCoord('g', 7), new Pawn b),
        new Square(new AlCoord('h', 7), new Pawn b),
      ],
      [
        new Square(new AlCoord('a', 6)),
        new Square(new AlCoord('b', 6)),
        new Square(new AlCoord('c', 6)),
        new Square(new AlCoord('d', 6)),
        new Square(new AlCoord('e', 6)),
        new Square(new AlCoord('f', 6)),
        new Square(new AlCoord('g', 6)),
        new Square(new AlCoord('h', 6)),
      ],
      [
        new Square(new AlCoord('a', 5)),
        new Square(new AlCoord('b', 5)),
        new Square(new AlCoord('c', 5)),
        new Square(new AlCoord('d', 5)),
        new Square(new AlCoord('e', 5)),
        new Square(new AlCoord('f', 5)),
        new Square(new AlCoord('g', 5)),
        new Square(new AlCoord('h', 5)),
      ],
      [
        new Square(new AlCoord('a', 4)),
        new Square(new AlCoord('b', 4)),
        new Square(new AlCoord('c', 4)),
        new Square(new AlCoord('d', 4)),
        new Square(new AlCoord('e', 4)),
        new Square(new AlCoord('f', 4)),
        new Square(new AlCoord('g', 4)),
        new Square(new AlCoord('h', 4)),
      ],
      [
        new Square(new AlCoord('a', 3)),
        new Square(new AlCoord('b', 3)),
        new Square(new AlCoord('c', 3)),
        new Square(new AlCoord('d', 3)),
        new Square(new AlCoord('e', 3)),
        new Square(new AlCoord('f', 3)),
        new Square(new AlCoord('g', 3)),
        new Square(new AlCoord('h', 3)),
      ],
      [
        new Square(new AlCoord('a', 2), new Pawn w),
        new Square(new AlCoord('b', 2), new Pawn w),
        new Square(new AlCoord('c', 2), new Pawn w),
        new Square(new AlCoord('d', 2), new Pawn w),
        new Square(new AlCoord('e', 2), new Pawn w),
        new Square(new AlCoord('f', 2), new Pawn w),
        new Square(new AlCoord('g', 2), new Pawn w),
        new Square(new AlCoord('h', 2), new Pawn w),
      ],
      [
        new Square(new AlCoord('a', 1), new Tower w),
        new Square(new AlCoord('b', 1), new Horse w),
        new Square(new AlCoord('c', 1), new Bishop w),
        new Square(new AlCoord('d', 1), new Queen w),
        new Square(new AlCoord('e', 1), new King w),
        new Square(new AlCoord('f', 1), new Bishop w),
        new Square(new AlCoord('g', 1), new Horse w),
        new Square(new AlCoord('h', 1), new Tower w),
      ],
    ]
  }
}
```

We have a board, and it's populated with pieces. How does it interact with the rest of the game? It has a `move` method that takes in a string of the form `<file><rank>-<file><rank>` which represent a move from a square to another. As described above, we need to make sure this is a legal move. If it's not, we can throw an error, otherwise we perform the move and return any taken enemy piece.

With that in mind, we can start sketching the basic layout.

```
class Chess {
  include Inputable

  constructor() {
    this.is_running = true
    this.players = [new Player(Player::BLACK), new Player(Player::WHITE)]
    this turn = 0
    this.board = new Board
    this.fileManager = new FileManager
    this.game = new Game this
  }

  run() {
    puts "\nthe amazing...\nCHESS!\ncopyright @kxrn0, 1956\n"

    while this.is_running {
      this.main_menu

      return unless this.is_running

      this.game.game_loop
    }
  }

  private

  choose_option() {
    prompt = '> '
    test = input => input.to_i.between? 1, 3
    error_message = 'Please enter a valid option!'

    get_input prompt, test, error_message
  }

  choose_turn_option() {
    prompt = '> '
    test = input => input.to_i.between? 1, 3
    error_message = 'Please enter a valid option!'

    get_input prompt, test, error_message
  }

  handle_turn_option(choice) {
    if choice.between? 1, 2
      this.turn = choice - 1
    else
      this.turn = rand 2
  }

  choose_first_turn() {
    puts "\nWho goes first?\n"
    puts "\n(1) - x\n(2) - o\n(3) - random\n"

    option = choose_turn_option

    handle_turn_option option.to_i
  }

  new_game() {
    this.board = new Board

    this.choose_first_turn
  }

  choose_game_index(count) {
    prompt = '> '
    test = input => input == 'b' || input.to_i.between?(1, count)
    error_message = 'Please enter a valid option!'

    get_input prompt, test, error_message
  }

  set_up_data(index) {
    data = this.file_manager.load_game index

    this.turn = data.turn
    this.board = new Board data.board

    true
  }

  handle_load_option(option) {
    return true if option == 'b'

    set_up_data(option.to_i - 1)
  }

  load_game() {
    puts "\nSaved games:\n"

    games = this.file_manager.load_saved_games_titles

    games.each (game, idx) => puts "(#{idx}) - #{game}"

    option = choose_game_index games.size

    handle_load_option index
  }

  handle_option(option) {
    switch option {
      when '1':
        this.load_game
      when '2': {
        this.new_game

        false
      }
      when '3':
        this.is_running = false
    }
  }

  main_menu() {
    is_maining = true

    while is_maining {
      puts "(1) - load game\n(2) - new game\n(3) - terminate program (not recommended)\n"

      option = this.choose_option
      is_maining = this.handle_option
    }
  }
}
```

I should test the `Chess` class.

How do I test that a new game is started without issues? I want to simulate a scenario where one game is played.
