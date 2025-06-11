# Hangman

First of all, I need to clean up the file. The instructions say that the word should have at least 5 characters, but there are many shorter words in the provided file.

I'll make a file without those words. The instructions also say that the words should be at most 12 characters long, but I'll ignore that.

## Sketch

The game should show the player what letters are correct, and which ones were wrong guesses. I think it would be better to show which letters are still available, so we'd show the player something like

```
p r _ g r _ _ _ _ _ g

q w e + t y u i o +
 a s d - + h j k l
  z x c v - n m

>
```

the first line is the word to be guessed, the grid below is the available letters. A `+` symbol means that guess was correct, a `-` one means the guess was wrong. The last line is just a `>` prompting the user for the next input.

The player can save and load games. They should also be able to delete them.

This is what a run may look like

```
The Amazing
H A N G M A N
copyright @kxrn0, 1976

H E L P:
  !n      - New Game!
  !s      - Show Saved Games!
  !l <\d> - Load Saved Game!
  !d <\d> - Delete Saved Game!
  !c      - Save Current Game!
  !h      - Print Help Menu!
  !e      - Terminate Program! (not recommended)

> !s

S A V E D  G A M E S
  (1) manhang - 2025-06-09 09:17:00
  (2) gem - 2025-06-09 09:17:00
  (3) other game - 2025-06-09 09:17:00
  (4) mmm - 2025-06-09 09:17:00

> !c

Please enter a valid input!

> !d

Please enter an index!

> !d 3

Deleted game 'other game - 2025-06-09 09:17:00'

> !s

S A V E D  G A M E S
  (1) manhang - 2025-06-09 09:17:00
  (2) gem - 2025-06-09 09:17:00
  (3) mmm - 2025-06-09 09:17:00

> !n

_ _ _ _ _ _

q w e r t y u i o p
 a s d f g h j k l
  z x c v b n m

(8 / 8) > help

Please enter a bang (!) command or a free letter!

(8 / 8) > !h

H E L P:
  !n      - New Game!
  !s      - Show Saved Games!
  !l <\d> - Load Saved Game!
  !d <\d> - Delete Saved Game!
  !c      - Save Current Game!
  !h      - Print Help Menu!
  !e      - Terminate Program! (not recommended)

(8 / 8) > b

_ _ _ _ _ _

q w e r t y u i o p
 a s d f g h j k l
  z x c v - n m

(7 / 8) > !c

Save game as > the geimu

Game saved as 'the geimu - 2025-06-09 09:17:00'!

(7 / 8) > !l 100

Index out of bounds!

(7 / 8) > c

_ _ _ _ _ _

q w e r t y u i o p
 a s d f g h j k l
  z x - v - n m

(7 / 8) > o

o _ _ _ _ _

q w e r t y u i + p
 a s d f g h j k l
  z x - v - n m

(7 / 8) >
```

And so on until the user guesses the word, or they run out of guesses. The number of gusses available is only decreased if they guess wrong.

## Architecture

There's a main `Game` object that keeps track of the running state of the overall program. The `main` file will look like this

```
game = new Game

game.play
```

Thus, the game won't start to play the moment the `Game` instance is created, but after its `play` method is called.

I think I could have `Player` and `Coder` classes to handle some of the game logic.

The `Player` class makes sure only valid human input makes it to the rest of the game. For example, in the prompt the human can type whatever while playing, but we only want it to enter a bang command or a free letter. We can have a single class making sure the rest of the program only sees valid input. It won't be as straighforward, as the prompt gets input that can be handled by different classes; if the human enters a free letter, we feed it to the `Coder`, if they enter a command to look at saved files, a file handling class should take care of that. I think there should be an intermediary `InputHandler` class that takes care of directing the input to the correct class.

### `Game`

A bird's eye view of this class is

```
class Game {
  static OPTIONS = ((a..z).to_a
    + ['!n', '!s', '!l', '!d', '!c', '!h', '!e']).freeze

  static MAX_GUESSES = 8!

  constructor() {
    this.player = null
    this.coder = null
    this.inputHandler = null
    this.fileManager = null
    this.running = true
    this.gaming = true
    this.terminated = false
  }

  set_up() {
    this.player = new Player
    this.coder = new Coder this
    this.inputHandler = new InputHandler this
    this.fileManager = new FileManager
    this.running = true
    this.gaming = true
    this.terminated = false
  }

  print_help() {
    puts <<~HEREDOC
      H E L P:
        !n      - New Game!
        !s      - Show Saved Games!
        !l <\d> - Load Saved Game!
        !d <\d> - Delete Saved Game!
        !c      - Save Current Game!
        !h      - Print Help Menu!
        !e      - Terminate Program! (not recommended)
    HEREDOC
  }

  print_intro() {
    puts <<~HEREDOC
      The Amazing
      H A N G M A N
      copyright @kxrn0, 1976
    HEREDOC

    print_help
  }

  game_loop() {
    this.inputHandler.handle_input while this.gaming
  }

  play() {
    this.print_intro

    while this.running {
      this.set_up
      this.game_loop

      this.running = this.play_again? unless this.terminated
    }
  }
}
```

This doesn't take into consideration the fact that we need to serialize and deserialize files. For now let's assume `InputHandler` knows how to handle input properly, and send it to the correct instance. I don't think the `Game` instance itself will receieve input, however it's state will certainly be changed by giving input to other instances that live in it.

I think the pseudocode above will need some big changes, but we need to flesh out all classes a bit more.

### `Player`

The player keeps track of how many guesses it has left, and makes sure only valid input flows from the human to the rest of the program.

```
class Player {
  constructor() {
    this.guesses = Game::MAX_GUESSES
  }

  enter_option() {
    badInput = true

    while badInput {
      input = gets.downcase

      if Game::OPTIONS.include? input
        return input

      puts "Please enter a valid input!"
    }
  }
}
```

The class is disposable, which means that once the game is over, the current instance is thrown away, and a new one is created, so the class shouldn't need a `reset` method.

### `Coder`

This class provides the secred word, and prints the grid of remaining letters.

Like the `Player` class, the instances of this class should be disposable.

```
class Coder {
  static CHARS = [
    ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
       ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
          ['z', 'x', 'c', 'v', 'b', 'n', 'm']
  ]

  constructor(game) {
    this.secret = game.fileManager.select_random_word
    this.hits = []
    this.misses = []
  }

  draw_row(row, index) {
    strow = ' ' * index

    for char of row {
      if this.hits.include? char
        strow += ' +'
      else if this.misses.include? char
        strow += ' -'
      else
        strow += ` ${char}`
    }

    strow
  }

  draw_keyboard() {
    Coder::CHARS.forEach((row, index) => puts this.draw_row row, index)
  }
}
```

### `InputHandler`

The `Player` above already makes sure the only input that flows from the human to the program is of the expected kind. Still, we still need to know where to send the input to.

If the human enters a command like `!s` that wouldn't be considered a game move; the number of guesses, and state of letters wouldn't change. The pattern I'm thinking about may only apply to turn based multiplayer games, so I don't think we'll see the following pattern in here

```
done = false

until done {
  input = gets

  if input_advances_the_state_of_game input {
    done = true
    // rest of the fucking...
  } else
    perform_side_action input
}
```

who handles the input? or whatever?

#### `!n`

We start a new game. If this is entered while a game is in progress, we first ask the human if they want to discard the current game.

The `Player` is disposable, the `Coder` is disposable, the `InputHandler` and `FileManager` aren't necessarily disposable, but they should be kind of stateless (they still could hold a reference to the current `Game` object), so they can be disposable as well, thus the only one who can respond to this command is the `Game` instance.

#### `!s`

I think the `Game` should get this command, but it itself calls the `FileManager` like

```
class Game {
  // rest of the fucking...

  print_games() {
    savedGames = this.fileManager.read_saved_games

    puts savedGames
  }

  // rest of the fucking...
}
```

#### `!l`

Similar to above, this command calls a method of `Game` that does stuff like using its `FileManager` to load the game data, and reset the game state.

#### `!d`

Similar to above.

#### `!c`

The `Game` instance has to take this one, as it has the data that needs to be saved.

#### `!h`

`Game`

#### `!e`

`Game`

### `FileManager`

It has methods to operate on the files.

---

## Implementation

I've written some code, however I overlooked some stuff, so I'll probably have to rewrite some parts.

In the sketch above, the prompt is `>` before the game starts, and it switches to `(8 / 8) > ` once the game starts. I shouldn't overcomplicate things like this. Instead, I'll make it so that a game starts the moment `play` is called on the `Game` instance.
