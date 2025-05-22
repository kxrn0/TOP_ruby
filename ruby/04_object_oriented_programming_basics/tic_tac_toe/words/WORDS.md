# Tic-tac-toe

I will need a board, player, and game objects.

The board object stores the state of the board, and takes care of updating it when a user makes a move.

The player object keeps track of the score, name, and whatever other information is necessary to have a player.

The game object takes care of game stuff, like indicating which player's turn is next, and handling other input necessary to run the game.

## Sketch

The game starts by asking the two players their names, and who they want to go first.

The game will use `o` and `x` as the markers.

```
TIC TAC TOE
copyright @kxrn0, 1985

The game will use noughts (o) and crosses (x) for the markers.

Who will be noughts? > player one

Who will be crosses? > player two

Who will go first?
  (a) - noughts (o), 「player one」
  (b) - crosses (x), 「player two」
  (c) - random
Enter a, b, or c > a

Help:
  h             - show help menu
  b             - show board
  s             - show current scores
  c             - toggle cell numbers
  r             - restart this game
  k             - reset everything
  e             - terminate program
  <cell_number> - choose a cell

The game is loading, please wait warmly...

     |     |
     |     |
____1|____2|____3
     |     |
     |     |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

「player one」 > 5

     |     |
     |     |
____1|____2|____3
     |     |
     |  o  |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

「player two」 >
```

And they keep playing until there's a winner or a tie.

```
「player one」 > 3

     |     |
     |  o  |..o..
____1|____2|____3
     |     |
  x  |..o..|
____4|____5|____6
     |     |
..o..|  x  |  x
    7|    8|    9

「player one」 WINS!

CURRENT SCORE:
  「player one」: 1
  「player two」: 0

Do you wish to play again (y / n)? >
```

We will also need to handle errors and accidental inputs.

```
「player one」 > h

Help:
  h             - show help menu
  b             - show board
  s             - show current scores
  c             - toggle cell numbers
  r             - restart game
  k             - reset everything
  e             - terminate program
  <cell_number> - choose a cell

「player one」 > c

Cell numbers disabled

     |     |
     |     |
_____|_____|_____
     |     |
     |  o  |
_____|_____|_____
     |     |
     |     |
     |     |

「player one」 > c

Cell numbers enabled

     |     |
     |     |
____1|____2|____3
     |     |
     |  o  |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

「player one」 > 100

Invalit input! Please enter a number in [1, 9], or a help command!

「player one」 > b

     |     |
     |     |
____1|____2|____3
     |     |
     |  o  |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

「player one」 > r

Restart current game? progress will be lost (y / n) > n

「player one」 > e

Terminate program (y / n)? >
```

## Implementation

From the sketch it looks like we'll also need a class for handling the input. We show a message to the user, let them enter an option, check it's a valid one, if it is, we let them continue, otherwise we show them an error, etc. It may be a bit more complicated when we want to ask for confirmation, or it may not, and it may just require using two input objects.

Regardless. We want `main.rb` to look like this

```ruby
require_relative "lib/Game"

game = Game.new

game.start
```

So we know that the `Game` object will have a `Board` and two `Player` objects. What is `start`? It will start the game, it will kick off the game loop.

What do we initialize a `Game` object with? The `Player` objects will be set once the players enter their names and start the game, but not on initialization of a `Game` object. The `Board` object can also be initialized right after the game is started, so we don't really need to initialize it here.

We can initialize the many `Input` objects in here since they should always behave in the same way.

There's the `start` method. It should display the welcome message, set up the game, and start the game loop.

Can you add an instance variable to a class without it being initialized in `initialized`, or declaring attribute accessors?

[This seems to be possible](./demons/initialize_outside_of_initialize.rb), but feels like a bad idea to be adding instance variables to a class randomly.

All instance variables should be given a value in `initialize` even if it's `nil`, just to account for them.

---

Currently I have something, however I'm already over 100 lines of code, and I haven't implemented the game logic yet, only the logic for setting up a new game, so only this part

```
Who will be noughts? > player one

Who will be crosses? > player two

Who will go first?
  (a) - noughts (o), 「player one」
  (b) - crosses (x), 「player two」
  (c) - random
Enter a, b, or c > a
```

and that is by assuming there's an `Inputable` module that takes care of making sure the user enters the correct thing.

I may need a `GameInitializer` class to take care of this, and a `GameLogicker` for handling the logic, and a `Game` class to compose them together.

How would that work? The initializer initializes the variables, and the logicker logics the logic, but how does the initializer initialize the variables in the first place? The game state should be kept in the `Game` object. Much like lifting state in react, the initializer and logicker will be passed accessors to the `Game` state.

---

Rubocop is complaining about syntax like

```ruby
class Klass
     def initialize setter
          @setter = setter
     end

     def set_parent_state
          @setter 10
     end
end
```

in particular, the line

```ruby
@setter 10
```

is treated as a syntax error.

According to ClaudeGrokPT I can use composition with delegation, which means that the game object will have instance variables for the initializer and logicker, but they too will have an instance variable to this game object. In a simple demo I have to expose getter and setters of the game's state, which I don't want.

Another approach is with modules, but I again have to expose the game's internal state. I may go with this approach, as it feels more natural to have a set of tools the game uses to initialize and logic stuff, rather than individuals that live only for the sake of the game.

After [playing around a bit](./demons/lifting_state.rb), it looks like I don't need to expose anything to work with instance variables in modules.

---

The initializing part of the game is more or less done. There may be some bugs, but I should move on to the logic.

Once the game variables have been initialized with the initializable, it's time for the logickable to logic stuff.

Based on the sketch, there will be a game loop that will

1. print the board
2. ask the current player for input
   1. validate the input
3. compute the next board state
   1. if there's a winner, do stuff
   2. else go to 1

I think it will be more complicated than that, specially if we want to do things like restarting the game, or resetting everything.

What happens if the user wants to restart the current game, or reset everything? the logickable would need access to the `set_up_game` method of the initializable.

Maybe the logickable should only be concerned with updating the board and player states, and the game object itself should be the one handling the input, and making all the difficult decisions.

---

How much of the game logic should be handled by the `Game` object itself, and how much should be in the `GameLogickable` module?

Things like printing and updating the board, making sure the user enters the correct input, deciding what to do for every help option, those are things that should be handled by logickable module.

`Game` has a `start` method, it sets up the state of the game, and calls `play`, which is also part of the `Game` class.

---

It's weird to reference class instance variables in the modules, I mean things like

```ruby
module Mod
     def add_one
          @var + 1
     end
end
```

we expect the class the module is included in to have a `@var` instance variable.

I obsessed too much with copying the data flow model of react where programs are structured by components, and we lift state when needed.

There's nothing wrong with doing something like

```ruby
class Player
     def initialize game
          @game = game
     end
end

class Game
     def initialize
          @player = Player.new self
     end
end
```

and have `Player` and `Game` change each other's state inside their own methods.

Obsessing too much over the right architecture when I don't know anything about design patters is making me waste too much time.

---

This is a mess, I need to start over.

I have a `Game` class that is used to play tic-tac-toe.

According to the rules of ruby, a class may not be longer than 100 lines, a function may not be longer than ten lines, not take more than four parameters, and in general, the code should be simple, so splitting funcionality in thousands of different small classes is encouraged.

Due those constaints I have to write a class for every large aspect of the game, like, getting the players to enter their names and choosing who goes first already takes almost 90 lines of code, so I made a class, `GameInitializer`, that takes care of that.

Once the game has been initialized it starts playing.

As shown above, that consists of a loop where we print the board, ask the user for input, and do it all over again.

It's a bit more complicated than that because there are many options.

If the user enters a number, we update the board, and check if there's a winer. If there's a winner, we announce this, print the scores so far, and ask the players if they want to play again. Otherwise, we print the board again, ask for input, etc.

If the user enters something other than a number we do something, which may result in asking the same user for input, so there will be many constructs of the form

```
isDone = false

while isDone == false {
     choice = get_choice

     if choice == something
          isDone = true
}
```

The main game loop being one of them.

A class whose purpose is choose what to do based on input would probably be a good idea. Maybe not in a simple program like this one, but definitely in a more complex one.

What would such class take care of? I'm tempted to make it handle the life cycle of the program rather than just input, as input handling is mostly solved by the inputable module.

Let's try a `LifeCycleHandler` class.

It will need a `isRunning` instance variable that will be true as long as the program is running. This is one step above the main game loop, as this outer loop is also in charge of initializing stuff, so it goes like

```
this.isRunning = true
this.isGaming = true

while this.isRunning {
     this.game.start

     while this.isGaming {
          this.game.board.draw

          this.isInputing = true
          input = null

          while this.isInputing {
               input = get_input

               this.handle_input
          }

          this.update_state input

          winner = this.board.compute_winner

          if winner {
               this.rest_of_the_fucking
          }

     }
}
```

The life cycle class may make a game logic handler obsolete, as we can see if there's a winner by using a method from the `Board` class, and the rest of the game logic could be handled in the life cycle manager.

---

As noted above, there's a `@isRunning` variable that is true as long as the program is running. Once this variable is set to false, the program stops.

Needless to say, this variable is stored in the `LifeCycleManager` instance.

The game starts when the method `start` is called on the `Game` instance.

What happens in this method? I'd guess that some method of the `LifeCycleManager` is called in here to start the game loop.

But the game also needs to be initialized by asking the users for names and turn order, so the `Game#start` first calls `GameInitializer#set_up_game` and then the `LifeCycleManager` instance method.

What is this `LifeCycleManager` method called? does it just set up some stuff, and call the actual method that does the gaming, or is it responsible for it? I think it should be something like

```
play() {
     while this.isRunning {
          this.update

          if this.game.board.game_over
               print "game over, play again (y / n)? >"
               input = get_input

          if input == "n"
               this.isRunning = false
     }
}
```

It will be a bit more complicated than that. The player objects will keep track of scores, so once a game is over, the players can choose to start a new game with players with different names, or start a round with the same player objects.

The sketch

```
「player one」 > 3

     |     |
     |  o  |..o..
____1|____2|____3
     |     |
  x  |..o..|
____4|____5|____6
     |     |
..o..|  x  |  x
    7|    8|    9

「player one」 WINS!

CURRENT SCORE:
  「player one」: 1
  「player two」: 0

Do you wish to play again (y / n)? >
```

doesn't seem to take this into account.

If the players enter n, the program terminates.

If they enter y, they'll be asked if the game should be another round, or if they want to start from scratch.

```
Do you wish to play again (y / n)? > y

Start another round, or start from scratch?

(a) - new round
(b) - scrap

Enter a or b >
```

Then

```
Enter a or b > a

The game is loading, please wait warmly...

     |     |
     |     |
____1|____2|____3
     |     |
     |     |
____4|____5|____6
     |     |
     |     |
    7|    8|    9

「player one」 >
```

or

```
Enter a or b > b

TIC TAC TOE
copyright @kxrn0, 1985

The game will use noughts (o) and crosses (x) for the markers.

Who will be noughts? >
```

Thus, the `play` method is more like

```
play() {
     while this.isRunning {
          this.game.board.draw
          this.make_move

          winner = this.game.board.compute_winner

          unless winner.null? {
               this.reset
          }
     }
}
```
