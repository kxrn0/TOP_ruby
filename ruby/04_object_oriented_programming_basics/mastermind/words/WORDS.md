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
