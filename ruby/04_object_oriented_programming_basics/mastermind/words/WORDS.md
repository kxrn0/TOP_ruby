# Mastermind

As the instructions suggest, I'll first write an implementation where the computer creates the code, and the human has to break it. Once I'm done with that, I'll make it so that the human can create the code for the computer to break.

## How to play mastermind

How are the hints computed? There are two pegs, or in this case, symbols, `+`, and `-`.

`+` represents that a guess is part of the code, and it's in the correct place.

`-` represents that a guess is part of the code, but not in the correct place.

The code will be composed of only the symbols `[a, b, c, d]`.

If the code is `bcdd`, and the guess is `badc`, what should the hints be?

- The `b` is correct, so it should add a `+`
- There's no `a`
- The `d` is also correct, so another `+`
- The `c` is n the wrong place, so `-`

What about the other `d` in the code? should the `d` in the guess give us a `-` for it? My gut tells me no, but is it always that easy to tell?

If the code is `abcd`, and the guess is `aaaa`, the guess of course should be a singular `+`.

What if the guess is `cccc`? The hint should be a single `+` as well.

What that previous example tells us is that we won't be looping the characters of the guess, as if we were to do so, the first character would imply that there's a `-`, and the corresponding element in the code would be removed.

Thus, we'll probably be looping the code, and removing items from the guess.

Thus, we'll say that for every character that is in the code, check if there's a character in the guess that is the same... I think this won't work either by cause of it introducing similar issues.

Consider the code `abac`, and guess `bcad`. My gut tells me that the hints should be `+--`, the `+` coming from the third `a`, however if we use the approach suggested above, then we first see `a` in the code, then go through the guess and arrive at `a`, which is not in the same place as the `a` in the code, so this would be interpreted as a `-`, and we would ignore this `a` in the guess for subsequent checks of the remaining characters.

I think it's better to do two passes; the first one to find all `+`s, and the second one for all `-`s.

How do we indicate that items should be ignored? We can make arrays with the code and guess, then set to `nil` those that have already been paired.

Thus, for the code `abac`, and the guess `bcad` we have

```
code = code.split ''
guess = guess.split ''
```

we first check how many items are the same in both strings, and make them `nil`. In this case it's only the `a` character in the third place, thus, after that `hints` will be `+`, and the code and guess will be

```
['a', 'b', nil, 'c']  // code
['b', 'c', nil, 'd']  // guess
```

Can we do the thing now where we go item by item in the code array, and check if there's the same character in the guess array in some other place while guranteeing this will produce the correct hints? The only thing we want to know now if two characters are the same in both strings, and we know they can't be in the same place, so yes, we can do this safely.

## Sketch

Here's what a run of the game may look like

```
I created a four-letter code with the characters [a, b, c, d].
Your task is to crack it.

For every guess I'll provide some hints.

A + means a letter is in the correct spot.
A - means a letter is in the code, but in the wrong spot.

You have 12 guesses.

Enter a guess, or 'exit' to terminate the program (not recommended).

enter guess (12 / 12) > abcd

hits: + - -

enter guess (11 / 12) > bdca

hits: + + -

enter guess (10 / 12) > bbca

hints: + + +

enter guess (09 / 12) > baca

Correct!

Do you wish to play again (yes / no)? >
```

## Architecture

What will the game be made of? I want to keep the game very simple. There's only one player, and I don't want to keep track of scores, so if there's a game class the details of the player won't take much space, or rather, there won't be enough of a concept of a player as an entity separate from the game to need to make a class for it.

The game won't start playing when the `Game` class instance is created, but rather, when the `start` method is called on the class instance.

---

Things are awkward currently. The game loop is

```ruby
  def game_loop
    while @running
      act_on_input receive_input if @guesses > 1
      update if @running
    end
  end
```

looking at this code, the first thing that comes to mind is "what's wrong with there being one guess left? aren't we wasting a guess" and if I change the max number of guesses to 3 I only get to guess twice, so yeah, that's a bug.

Currently there's a big `Game` class that handles everything, if I try addig a few more variables the class length goes over the legal limit.

I need to break the class into smaller classes and figure out a better lifecycle.

I have some class variables like `CODE_SIZE`, `INIT_GUESSES`, etc. that I had to put outside the class because otherwise it would get too long. I think I should create a `GameState` class that holds those variables, and the game state like remaining guesses.

I think I can extract a `Coder` class from the `Game`. This class would represent the player that makes the code. It can have the functionality of creating new codes, and computing hint strings.

---

I made a `Coder` class. Now I want to make a `Guesser` one. What functionality can I extract from the `Game` class for this? The `Guesser` guesses. Currently the game is very simple; the computer comes up with a code, and the human guesses it, however according to the instructions I should extend it so that the roles can be reversed; the human comes up with the code, and the computer guesses it. I could split the `Coder` and `Guesser` classes in to `HumanCoder`, `ComputerCoder`, `HumandGuesser`, and `ComputerGusser`, however I will try to avoid doing that if necessary. I'll give each class a method to act in either case, so `Coder` will have the methods `generate_human_code` and `generate_computer_code`, each of which will be called depending on the roles... or should it? At this point it does sound sensible to split `Coder` and `Guesser` into human and computer specific subclasses, as each will have specific functions that may need a lot of code to be implemented, for example, for the `Guesser` class, if the guesser is human, it would be nice to make it so that the user is only able to enter strings that match `/^[abcdef]{4}$/`, and provide an error if they enter something else, while the computer guesser should have a simple strategy, it should keep track of things so that it can play somewhat intelligently. Adding all that disparate functionality to a single class would bloat it, and it may take it over the legal class length limit.

### Game

I want the manager class to not have to worry about the nature of the classes it deals with, whether they are human or computer.

What will the manager look like? I'll try to keep it all in one class, but I may have to split it into a logic manager, and an initializer.

The manager is the `Game` class. When an instance of `Game` is created, it doesn't start playing immediately. To start playing, the client has to call `play`. What does this method do? It sets up stuff. How much stuff? it depends. How should the game work? At the beginning of each session, the human can choose if they want to be the guesser or the coder, and then we start the game loop.

Thus, `play` should look like this

```
play() {
  this.print_intro

  while this.running {
    this.set_up
    this.game_loop

    this.running = this.play_again? unless this.terminated
  }
}
```

`set_up` asks the human if they want to be the guesser or the coder, and assings instance variables accordingly. We then loop the game until the game is over.

`game_loop` runs while the game is not over. It will look something like

```
game_loop() {
  while this.gaming {
    // handle game logic...
  }
}
```

once the game is over, we ask the player if they want to play again, but only if they din't terminate the game manually. We could set `running` to false when the user chooses to terminate, and do

```
this.running = this.play_again? unless this.running
```

but having an explicit `terminate` instance variable seems more semantic.

#### `set_up`

What does the game need? a coder and a guesser. In `set_up` we first ask the human if they want to be the coder or the guesser, and assign the instance variables appropriately.

```
set_up() {
  if this.human_coder? {
    this.coder = HumanCoder.new
    this.guesser = RobotGuesser.new
  } else {
    this.coder = RobotCoder.new
    this.guesser = HumanGuesser.new
  }

  this.coder.set_up
  this.gaming = true
}
```

We'll probably need the coder to prepare, if it's a robot coder, it generates a code, and if it's a human coder, we make it enter a code through the console.

#### `game_loop`

Ask the guesser for a guess, if the guess is correct, print game over, otherwise give them hints. The guesser can also enter `'exit'` to terminate the program completely. The robot guesser shouldn't be able to do that.

```
game_loop() {
  while this.gaming {
    guess = this.guesser.guess

    if guess == 'exit' {
      this.gaming = false
      this.running = false
      this.terminated = true
    } else if guess = this.coder.code {
      this.gaming = false
      puts 'GAME OVER! YOU WIN!'
    } else {
      this.guesses--

      if this.guesses == 0 {
        this.gaming = false
        puts "GAME OVER! YOU LOST! THE CODE WAS ${this.coder.code}!"
      } else {
        hints = this.coder.compute_hints guess
        this.guesser.give hints
      }
    }
  }
}
```

---

The `play_again?` method will be a simple method that just asks the user for a `'yes'` or `'no'`.
This should be it for the `Game` class.

### Coder

The job of this class is to create the code, and provide hints. There will be two classes, `HumanCoder`, and `RobotCoder`. Ideally each class would have a method for creating the code and providing hints, however I'll keep this simple, and use the same method in both for providing the hints. Instead of including the method in both separate classes, I can subclass them from a `Coder` object that has that method.

Thus, the robot and human coder share the `hints` method from the parent, and each has a `reset_code`.

The human `reset_code` code asks the user to enter a string matching `/^[abcdef]{4}$/i`. If the user enters something else, it prints an error message and asks them again.

The robot `reset_code` method can be just

```
reset_code() {
  this.code = []

  Coder.CODE_SIZE.times () => this.code.push Coder.PEGS.sample
}
```

### Guesser

The guesser guesses and gets hints.

The human guesser's `guess` method is another input loop that asks the user for a string matching `/^[abcdef]{4}$/`, and the `give` just prints the given hints to the console.

The robot guesser may be a bit more involved. For now let's say that it guesses randomly, and doesn nothing with the hints, but we'll expand it later.

#### AI

At this point the game seems to work, I just need to make the robot guesser smart.

I simple approach I've been using is as follows

- Make the first guess be all the same peg, like the first item of `Coder::PEGS`; `'a'`. If there's one or more hits, we know this item is in the code.
- Make the next guess the first two items of the previous guess, and the next two items being the next item in the array of pegs, so in our case `'aabb'`.
- Keep doing this will all remaining colors, this will give you an idea of which colors are in the code, and potentially their order.

For example, if the code is `'cbaa'`, then

- The first guess of `'aaaa'` would give `+ +`, thus we know there are exactly two `'a'` in the code.
- The second guess of `'aabb'` gives `- - -`. We can deduce that the `'a'`s are on the right, and there's one `'b'` on the left.
- The third guess of `'aacc'` gives `- - -`. Based on previous guesses, we knoe there's a `'c'` on the left.
- At this point we know there are two `'a'`s, one `'b'`, and one `'c'`, four items in total, so we don't need to check the rest of the colors, as we know they can't be there.
- We know the `'a'`s are on the rigth, and the other characters are on the left.
- It just remains finding all arrangements with the characters on the left, which are only `['cbaa', 'bcaaa']`.

How do I translate something like this to ruby? I need to be able to remember things, I need to test pairs of colors, with a base peg.

There's the step of figuring out what colors are in the code by checking pairs of them one by one. There are only six color, and we have twelve guesses, so we can perform this step without worring about running out of guesses.

I guess there will be a instance variable `colors_left_to_test` that will be > 0 as long as we haven't tested all colors. Thus, the `give` method may look like this

```
give(hints) {
  if this.colors_left_to_test > 0 {
    // rest of the fucking...

    this.colors_left_to_test--
  }
  else {
    // at this point we should know what colors are in the code
    // rest of the fucking...
  }
}
```

Since `colors_left_to_test` will start as the length `Coder::PEGS`, does it mean that we will test in reverse? Probably. Instead of starting with `'aaaa'` we'll start with `'ffff'`, follow with `'ffee'`, then `'ffdd'` and so on.

For the hints we are given an object with `pluses` and `minuses` properties.

Every set of hints should help make clear whether or not a color is in the code. I should keep an array with colors I'm certain are in the code, colors I'm certain are not in the code, and colors that could be in the code.

Guessing the colors in pairs can reveal if what side of the code a color is in, so it sounds like I'd need arrays for the sides.

```
class AIGuesser {
  constructor() {
    this.colorsLeft = Coder::PEGS.size
    this.baseColor = Coder::PEGS.at -1
    this.included = { left: [], right: [], somewhere: [] }
    this.excluded = []
    this.potential = []
    this.guesses = []
  }

  guess() {
    if this.colorsLeft > 0 {
      this.colorsLeft--

      secondComing = Coder::PEGS[this.colorsLeft]

      guess = "${this.baseColor * 2}${secondComing * 2}"

      this.guesses.push guess

      guess
    }
    else {
      // rest of the fucking...
    }
  }

  give(hints) {
    // rest of the fucking...
  }
}
```

The guesser class will be disposable; once a game is over, it will be discarded, that's why there's no `reset` method like in `Game`, thus, unlike in `Game` or `Coder` subclasses, the constructor has to initialize the variables to what they need to be, rather than giving them some default values, and waiting for a `reset` to make things right.

I'm assuming that once `colorsLeft` is zero we'll know for certain what colors are in the code. This may not be true, but I'll assume it is anyway, I just have to make sure we don't enter an infinite loop due to this.

So we made a guess, and are given some hints. We pushed the last guess we made to the `guesses` array, so we can retrieve it to analyze it.

The first guess is `'ffff'`. We will get either multiple `+` or nothing.

If we get nothing, we can add `'f'` to `excluded`, otherwise we do something else. If we guessed the code correctly we won't get hints. Thus we will only get [0, 3] pluses for the first guess.

Assume we got `n` pluses from our first guess. That means the remaning number of colors is `Coder::PEGS.size - n`. Spots, we need to think about how many spots we have left to fill. We don't necessarily need to test all pairs until we run out of colors, we can stop once all spots are filled.

Having all spots filled only tells us that we know what colors are in the code, but not in what order.

Thus, we need spots. We have four spots that need to be filled in.

When we first make our guess of `'ffff'`, we'll get some number of pluses. If we get zero, we add `'f'` to the array of colors we know are not in the code. If we get a nonzero number `n`, we set `spotsLeft` to `Coder::CODE_SIZE - n`.

Once `spotsLeft` is zero we start guessing, but until then we focus on filling out all the spots.

I think there should be a `Spots` object with four properties;

```
class Spots {
  constructor() {
    this.spotsLeft = Coder::CODE_SIZE
    this.left = []
    this.right = []
    this.potential = []
    this.excluded = []
  }

  // rest of the fucking...
}
```

I'm not sure how to go on from this point, I think I could simulate a lot of scenarios, and I'll hopefully figure it out at the end.

##### #1

Assume the code is `'bacd'`.

The first guess is `'ffff'`, the hints are `''`, thus, we add `'f'` to `excluded`.

The second guess is `'ffee'`. There are no hits again, so we add `'e'` to `excluded` as well.

The third guess is `'ffdd'`, the hints are `'+'`. We know there's no `'f'`, so there's exactly one `'d'` in the code, so we push `'d'` to `right`, and decrease `spotsLeft` by one.

The fourth guess is `'ffcc'`. We get the hints `'+'`. Like before, this tells us that there's a `'c'` on the right of the code, thus we push `'c'` to `right`, and decrease `spotsLeft`.

The next guess is `'ffbb'`, which gives us the hints `'-'`. We know there's a `'b'` on the left, so we push it to `left`. `spotsLeft` is now one.

The final guess is `ffaa`, which gives us `'-'`, and like above we push it to `left`. With this `spotsLeft` is now zero.

All spots are full, we have

```
left = [ b a ]
right = [ d c ]
```

but we don't know their exact positions. I could put in some effort, but I've already spent too much time in this. I'll just have it randomly shuffle the items.

We need to break the guess into its characters, and separate them by side.

In the third guess above, we get

```
leftGuess = [ f, f ]
rightGuess = [ d, d ]
```

If we check the items of `leftGuess`, we see that they are all already in `excluded`, so we don't need to bother with them.

What about the items in the right. They are nowhere in `spots`, and there's a `+` in the hints, which we know can't be in the left, so it must be in the right side of the code.

##### #2

Assume the code is `'cccb'`.

The first guess is `'ffff'`. There are no hits, so we add `'f'` to `excluded`.

The same thing happens with `'e'` and `'d'`, thus, after three guesses `spots` is

```
left = []
right = []
potential = []
excluded = [ f, d, e ]
spotsLeft = 4
```

The next guess is `'ffcc'`, which gives us `'+-'`. We know there's no `'f'` in the code, so since there are two hints and two items left, we know both of them are in the code. One is in the exact position, and the other not, and both are in the right, so we push `'c'` to both `left` and `right`, and decrease `spotsLeft` by one twice.

The next guess is `'ffbb'`, which gives us `'+'`, so we know there's a `'b'` on the right, and we push it. At this point `spots` is

```
left = [ c ]
right = [ c, b ]
potential = []
excluded = [ f, e, d ]
spotsLeft = 1
```

The final guess is `'ffaa'`, which gives us nothing. This leaves us with one empty spot.

I'll fill empty spots with `nil`, and when guessing I'll take a random non `nil` value from `left` or `right`. I could make the AI smarter by keeping track of how many times a color is in the code, in the example above we can deduce that `'b'` is there only once, and that `'c'` could be there another time, so the vacant spot should be filled with `'c'`, however I want to keep things simple, so I won't make `spots` any more complex.

---

Unfortunately I've run out of time, and the project can be considered to be in a state of completion, so I can no longer work on it.
