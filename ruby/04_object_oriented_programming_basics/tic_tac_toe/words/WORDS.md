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
