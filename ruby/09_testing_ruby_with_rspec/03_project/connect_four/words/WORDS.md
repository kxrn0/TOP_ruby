# Connect Four

## Sketch

### HP

```
CONNECT FOUR

copyright @kxrn0, 1977

Who should go first?

(1) - x
(2) - o

> 1

「x」 will go first.

Enter a column number, or `exit` to terminate the program (not recommended).

___________________________________________
|__1__|__2__|__3__|__4__|__5__|__6__|__7__|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|

「x」 > 2

___________________________________________
|__1__|__2__|__3__|__4__|__5__|__6__|__7__|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |  x  |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|

「o」 >
```

The game would continue until someone wins

```
「o」 > 6

___________________________________________
|__1__|__2__|__3__|__4__|__5__|__6__|__7__|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |  o  |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |  o  |  x  |  x  |  o  |  x  |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |  x  |  o  |  o  |  o  |  x  |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |  x  |  x  |  o  |  o  |  x  |  o  |
|_____|_____|_____|_____|_____|_____|_____|

「x」 > 5

___________________________________________
|__1__|__2__|__3__|__4__|__5__|__6__|__7__|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |  +  |     |     |
|     |     |     |  o  |+ x +|     |     |
|_____|_____|_____|_____|__+__|_____|_____|
|     |     |     |  +  |     |     |     |
|     |     |  o  |+ x +|  x  |  o  |  x  |
|_____|_____|_____|__+__|_____|_____|_____|
|     |     |  +  |     |     |     |     |
|     |     |+ x +|  o  |  o  |  o  |  x  |
|_____|_____|__+__|_____|_____|_____|_____|
|     |  +  |     |     |     |     |     |
|     |+ x +|  x  |  o  |  o  |  x  |  o  |
|_____|__+__|_____|_____|_____|_____|_____|


GAME OVER!
「x」 wins!
```

All winning combinations will be highlighted.

If the board fills up before there's a winner, the message indicates so

```
GAME OVER!
it's a tie!
```

After the game is over the players are asked if they want to play again.

```
play again (y / n) >
```

If they choose `y`, everything is reset.

### UHP

There are three places the user enters something

- who goes first
- column number
- play again

#### who goes first

If the user enters anything other than 1 or 2, we show them an error message.

```
Who should go first?

(1) - x
(2) - o

> me

Please enter '1' or '2'!

> you

Please enter '1' or '2'!

>
```

#### column number

It has to be a valid column number or `exit`, and the column has to not be full.

```
___________________________________________
|__1__|__2__|__3__|__4__|__5__|__6__|__7__|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |  o  |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |  o  |  x  |  x  |  o  |  x  |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |  x  |  o  |  o  |  o  |  x  |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |  x  |  x  |  o  |  o  |  x  |  o  |
|_____|_____|_____|_____|_____|_____|_____|

「x」 > 100

Invalid column number!

「x」 >
```

```
___________________________________________
|__1__|__2__|__3__|__4__|__5__|__6__|__7__|
|     |     |     |     |     |     |     |
|     |     |     |  o  |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |  x  |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |     |  o  |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |  o  |  x  |  x  |  o  |  x  |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |     |  x  |  o  |  o  |  o  |  x  |
|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |
|     |  x  |  x  |  o  |  o  |  x  |  o  |
|_____|_____|_____|_____|_____|_____|_____|

「x」 > 4

Column full! choose a different one!

「x」 >
```

### play again

Anything other than `/^([yn]|yes|no)$/i` will show an error.

```
play again (y / n) > maybe

Please enter 'y' or 'n'!

play again (y / n) >
```

## Architecture

There will be three main classes; `Game`, `Player`, and `Board`. Maybe even a `Column` one.

## TDD (Total Developer Death)

> Think of a feature, write a failing test for it, write code to make the test pass, and refactor.

### `Game`

It takes care of the overall life cycle of the program, and the game logic.

#### `run`

Where do I start? I think the least I can do is create a `Game` class, give it a `run` instance method, and test that `run` calls the methods necessary for making the game run.

I need to come up with the lifecycle of the program, and test that it is followed correctly.

In the beginning, when the `Game` instance is created, the game doesn't start immediately. Rather, it's until we explicitly call `run` on it, so this is how we'd use it.

```ruby
game = Game.new

game.run
```

is that a good idea? I don't know, but I don't think it's that much of a bad idea either, so I'll go with it.

Thus, when `run` is called it starts the program.

```
run() {
  while this.isRunning {
    set_up
    game_loop

    this.isRunning = play_again? if this.isRunning
  }
}
```

This would make `run` a looping script method. We'll test that it calls the methods it's supposed to call. This feels meaningless now, but it may help in the future if `run` is refactored.

#### `set_up`

As the name implies, it sets up the game with the necessary values to start playing. The players are created the moment the `Game` constructor is called, and don't change after that. We could do the same thing with the board, but we'd have to add a `reset` method to the `board` class, and remember to call it before starting a new game, so I think it's easier to just throw away the old board and get a new one each game.

We also set up the turn in here.

Looking at the sketch above we have

```
CONNECT FOUR

copyright @kxrn0, 1977

Who should go first?

(1) - x
(2) - o

> 1

「x」 will go first.

Enter a column number, or `exit` to terminate the program (not recommended).
```

I'm tempted to have an `intro` method responsibly for printing the lines

```
CONNECT FOUR

copyright @kxrn0, 1977
```

so that that part is only printed once at the beginning of the game, but for the sake of simplicity I'll have all the lines in the intro be printed by `set_up`.

At this point I need to have a clear model of how to let the user input things. I can do something like

```
get_input(prompt, test, error) {
  loop {
    print prompt

    input = gets.chomp

    if test.call input
      return input

    puts error
  }
}
```

With that in mind, I think `set_up` should look like this

```
set_up() {
  print_intro

  init_board
  choose_first_mover

  print_instructions
}
```

with `print_intro` printing

```
CONNECT FOUR

copyright @kxrn0, 1977
```

`print_instructions` printing

```
Enter a column number, or `exit` to terminate the program (not recommended).
```

`init_board` can be as simple as

```
init_board() {
  this.board = new Board
}
```

and `choose_first_mover` does as the name implies.

This would make `set_up` a script method, so there should be no need to test it, only the methods it calls, and of those methods I think only `choose_first_mover` is worth testing.

#### `choose_first_mover`

```
choose_first_mover() {
  instructions = "Who should go first?\n\n(1) - x\n(2) - o\n"

  puts instructions

  prompt = '> '
  test = input => input.match /^[12]$/
  error = "Please enter '1' or '2'!"
  input = get_input prompt, test, error
  index = input.to_i

  this.turn = index

  name = this.players[index].name

  puts "「#{name}」 will go first"
}
```

That's quite lengthy, rubocop will likely complain. I'll take the input part into another method

```
choose_index() {
  prompt = '> '
  test = input => input.match /^[12]$/
  error = "Please enter '1' or '2'!"
  input = get_input prompt, test, error

  input.to_i
}

choose_first_mover() {
  instructions = "Who should go first?\n\n(1) - x\n(2) - o\n"

  puts instructions

  this.turn = choose_index

  name = this.players[this.turn].name

  puts "「#{name}」 will go first"
}
```

I could further split

```
instructions = "Who should go first?\n\n(1) - x\n(2) - o\n"

puts instructions
```

and

```
name = this.players[this.turn].name

puts "「#{name}」 will go first"
```

into its own methods, but if I keep doing that then the class would be littered with many one-liner one-off methods, which would increase the line count of the class, making rubocop complain. That could be a good thing. It would make me see that I can split `Game` into simpler classes. I'll make a method for the simple functionality for now.

```
choose_index() {
  prompt = '> '
  test = input => input.match /^[12]$/
  error = "Please enter '1' or '2'!"
  input = get_input prompt, test, error

  input.to_i
}

print_mover_instructions() {
  instructions = "Who should go first?\n\n(1) - x\n(2) - o\n"

  puts instructions
}

print_first_mover_name() {
  name = this.players[this.turn].name

  puts "「#{name}」 will go first"
}

choose_first_mover() {
  print_mover_instructions

  this.turn = choose_index

  print_first_mover_name
}
```

Feels awkward to have to write tests for something like this, I have to constantly remind me that while it may not make too much sense to test something so simple, it would pay off in the future if I were to refactor the code. But this raises the question of what to test? If I refactor `choose_first_move` to call other methods, I'd also have to refactor the tests if I'm testing by expecting method calls, which would invalidate the premise that the tests are there to make sure things don't break after a refactor, as the tests themselves would break after it.

What would I even need to test in this particular case? If I'm not checking for method calls, then I'd need to check that `turn` is given a value.

I'll stop overthinking and just test the method calls and that `turn` is given a value.

