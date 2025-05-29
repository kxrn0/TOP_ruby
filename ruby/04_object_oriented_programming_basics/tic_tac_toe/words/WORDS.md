# Tic Tac Toe

A very simple game of tic-tac-toe.

## Sketch

The program is run, then we see

```
Randomly choosing who goes first, please wait warmly...

Enter a valid cell number, or 'exit' to exit the game.

「x」 goes first

     |     |
     |     |
____1|____2|____3
     |     |
     |     |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

「x」 > 3

     |     |
     |     |  x
____1|____2|____3
     |     |
     |     |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

「o」 >
```

Who goes first is decided randomly, then the board is printed, and we get a prompt for the current player.

If the player enters invalid input, we print an error and prompt them again.

```
     |     |
     |     |  x
____1|____2|____3
     |     |
     |     |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

「o」 > 3

Invalid input! please enter an empty cell number or 'exit' to terminate the program!

「o」 > no u

Invalid input! please enter an empty cell number or 'exit' to terminate the program!

「o」 > 4

     |     |
     |     |  x
____1|____2|____3
     |     |
  o  |     |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

「x」 > exit

Shutting down...

```

When the game is won, or when there's a tie we ask the players if they want to play again.

```
     |     |
  x  |  x  |  x
____1|____2|____3
     |     |
  o  |  o  |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

GAME OVER! 「x」 is the winner!

WINS:
  「x」 : 1
  「o」 : 0

Play again (yes / no)? > はい

Invalid input! please enter 'yes' or 'no'!

Play again (yes / no)? > yes

Randomly choosing who goes first, please wait warmly...

Enter a valid cell number, or 'exit' to exit the game.

「o」 goes first

     |     |
     |     |
____1|____2|____3
     |     |
     |     |
____4|____5|____6
     |     |
     |     |
    7|    8|    9
```

## Architecture

It's clear that we will have a game object with a game loop, something like

```
game_loop() {
  while this.is_running {
    choose_who_goes_first
    set_up_stuff
    print_instructions

    while this.is_gaming {
      print_board
      print_current_user_prompt
      input = get_user_input
      handle_user_input input

      winner = this.board.compute_winner

      if winner || this.board.full? {
        print_results winner

        this.is_gaming = false
      }
    }

    this.is_running = play_again?
  }
}
```

Thus, we have a main game object that manages the lifecycle of the program. We also have board and player objects. The board object can be just an object with an array of values, each representing an empty cell or a cell taken by a player. The player object keeps track of its wins and identity.

Rather than start playing when the game is created, there should be a `start` function that starts the game loop, so `main.rb` can look like this

```ruby
game = Game.new

game.start
```

I think most stuff is done, I only need to figure out how to print the board.

I a past life I tried building the cells one by one, and then joining them, however that's clearly hard to do given that the pieces of text have `'\n'` at the end, so you can't just join them.

I think a similar approach would work but building row by row.

A row is composed of three layers

```
     |     |
  o  |     |  x
____1|____2|____3
```

```
to_s() {
     width = 3
     height = 3
     layers = 3
     grid = ''

     height.times y => {
          row = ''

          layers.times l => {
               layer = ''

               width.times x => {
                    index = x + y * width
                    cell = ''

                    switch l {
                         when 1 {
                              cell = ' ' * 5
                         }
                         when 2 {
                              value = this.cells[index]
                              marker = value.null? ' ' : value
                              spaces = ' ' * 2

                              cell = "${spaces}${marker}${spaces}"
                         }
                         when 3 {
                              unders = '_' * 4
                              number = (index + 1).to_s

                              cell += "${unders}${number}"
                         }
                    }

                    wall = x == width - 1 ? '' : '|'
                    cell += wall

                    layer += cell
               }

               row += layer
          }

          grid += row
     }

     grid
}
```

that's certainly way more characters than

```ruby
  def draw
    puts "
       |     |
      #{@cells[0] || ' '} |  #{@cells[1] || ' '}   |  #{@cells[2] || ' '}
      0|    1|    2
  -----.-----.-----
       |     |
      #{@cells[3] || ' '} |  #{@cells[4] || ' '}   |  #{@cells[5] || ' '}
      3|    4|    5
  -----.-----.-----
       |     |
      #{@cells[6] || ' '} |  #{@cells[7] || ' '}   |  #{@cells[8] || ' '}
      6|    7|    8
  "
  end
```

The pseudocode doesn't quite work. I managed to fix the bugs, now there's a last bug. The numbers at the bottom have to be the same lenght. I shoudln't be overcomplicating this as much as I am, but the fix seems to take just a bit of effort to leave it just like that.

If I print a board of dimensions 5x4 the result is

```
     |     |     |     |
     |  x  |  x  |  o  |
____1|____2|____3|____4|____5
     |     |     |     |
     |     |  o  |  x  |  o
____6|____7|____8|____9|____10
     |     |     |     |
  x  |  o  |  x  |     |
____11|____12|____13|____14|____15
     |     |     |     |
     |     |     |  o  |
    16|    17|    18|    19|    20
```

The solution is add a padding of however many `'-'` it takes to make the bottom number have the same length as the longest bottom.

The longest bottom is `gest = @width * @height`, if the current number is `n`, then the number of padding `'-'`s we need is `gest.to_s.size - n.to_s.size`. I half want to cache `gest` while stringifying the board, but don't want to make it an instance variable so it'd have to be passed around as a method parameter, but that'd make things a bit harder to read, so I think in the end I should compute all those in the fly.

The first attempt failed because I forgot I had to pad the other two layers as well.

How do I distribute the padding in the middle layer? is it possible to distribute it evenly? This is getting out of hand. The board will always be 3x3, so the current solution works perfectly fine for it.
