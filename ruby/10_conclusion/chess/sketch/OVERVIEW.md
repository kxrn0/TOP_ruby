# Chess

When the program starts, a welcome message is printed, and then a menu for the options.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit

Enter choice >
```

If the user enters something other than an option, an error is printed.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit

Enter choice > a

Please enter a valid choice!

(n) - Start new game
(s) - Load game
(e) - Exit

Enter choice >
```

A similar pattern will be followed by other selection menus.

## Main Menu

### (n) - Start new game

If the players choose to start a new game, they will first be queried for their names.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit

Enter choice > n

Enter the first player's name >
```

The players are expected to enter their names one after the other.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit

Enter choice > n

Enter the first player's name > Alice
Enter the second player's name > Bob
```

Both players can't have the same name, if the second player tries to enter the first player's name, they will be stuck in a loop until they enter a valid one.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit

Enter choice > n

Enter the first player's name > Alice
Enter the second player's name > Alice

Please enter a different name!

Enter the second player's name >

Please enter a different name!

Enter the second player's name > Bob
```

After the players have entered their names, they will be randomly assigned a color, and then presented with a menu.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > n

Enter the first player's name > Alice
Enter the second player's name > Bob

Players will be randomly assigned a color

Alice will be white ♔
Bob will be black ♚

Game Menu

(c) - Start game
(g) - Save game
(i) - How to play
(t) - End game
(h) - Game menu
(a) - Toggle coordinates

Enter choice >
```

The players can now select an option.

#### (c) - Start game

This option will start the playing game loop. There will be two loops in the game; the outer loop that has users choosing any of the Menu options, this is where setting up the game is done. The other loop is the inner loop, this is where all the gaming takes place.

This option starts the inner game lopp. First the board state is printed

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > n

Enter the first player's name > Alice
Enter the second player's name > Bob

Alice will be white ♔
Bob will be black ♚

Game Menu

(c) - Start game
(g) - Save game
(i) - How to play
(t) - End game
(h) - Game menu
(a) - Toggle coordinates

Enter choice > c

□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ ♜ □ ■ ♞ ■ □ ♝ □ ■ ♛ ■ □ ♚ □ ■ ♝ ■ □ ♞ □ ■ ♜ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ♟ ■ □ ♟ □ ■ ♟ ■ □ ♟ □ ■ ♟ ■ □ ♟ □ ■ ♟ ■ □ ♟ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ ♙ □ ■ ♙ ■ □ ♙ □ ■ ♙ ■ □ ♙ □ ■ ♙ ■ □ ♙ □ ■ ♙ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ♖ ■ □ ♘ □ ■ ♗ ■ □ ♕ □ ■ ♔ ■ □ ♗ □ ■ ♘ ■ □ ♖ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □

Alice >
```

The players can now start playing. The players can enter algebraic notation to make a move, or one of the options in the game menu that make sense.

#### (g) - Save game

This option will prompt the users for a name to save the game

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > n

Enter the first player's name > Alice
Enter the second player's name > Bob

Alice will be white ♔
Bob will be black ♚

Game Menu

(c) - Start game
(g) - Save game
(i) - How to play
(t) - End game
(h) - Game menu
(a) - Toggle coordinates

Enter choice > g

Enter name for the game > the game

Game saved

Enter choice > g

You can't save this game again

Enter choice >
```

#### (i) - How to play

This option prints instructions on how to play

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > n

Enter the first player's name > Alice
Enter the second player's name > Bob

Alice will be white ♔
Bob will be black ♚

Game Menu

(c) - Start game
(g) - Save game
(i) - How to play
(t) - End game
(h) - Game menu
(a) - Toggle coordinates

Enter choice > i


Instructions

The player will be presented with a prompt of the form

player name >

The player is then expected to enter an option from the game menu
or a move in the form of algebraic notation.
```

### (s) - Load game

This option lets users load a game stored in memory.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > s

(1) - random title
(2) - the game
(3) - the other one

Enter game number >
```

If there are no games in memory we go back to the main menu.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > s

No games saved
Going back to main menu

##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice >
```

Due to how games will be stored, it could be that a game listed in the selected menu doesn't exist, an appropriate message will be displayed in that case, and that game will be removed from the list of games.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > s

(1) - random title
(2) - the game
(3) - the other one

Enter game number > 2

The data for the game

"the game"

seems to have been corrupted, please choose a different one

(1) - random title
(3) - the other one

Enter game number >
```

Once a valid game has been selected, it is set up, and the players can start playing.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > s

(1) - random title
(2) - the game
(3) - the other one

Enter game number > 2

...Loading game...

Players

Alice - white ♔
Bob - black ♚

□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ ♕ □ ■ ■ ■ □ □ □ ■ ■ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ♙ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ ♔ □ ■ ♙ ■ □ □ □ ■ ■ ■ □ ♘ □ ■ ■ ■ □ ♙ □ ■ ■ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ ♛ □ ■ ■ ■ □ ♙ □ ■ ■ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ □ □ ■ ■ ■ □ ♟ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ■ ■ □ ♚ □ ■ ■ ■ □ ♟ □ ■ ♝ ■ □ □ □ ■ ♟ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
□ ♟ □ ■ ■ ■ □ ♟ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ♟ ■
□ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □
■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □ ■ ■ ■ □ □ □

Bob >
```

### (e) - Exit

This option terminates the program.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > e
```

### (m) - Menu

This option prints the main menu.

```
##########################
#                        #
#  Chess                 #
#  Copyright kxrn0 1987  #
#                        #
##########################

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu

Enter choice > m

Menu

(n) - Start new game
(s) - Load game
(e) - Exit
(m) - Menu
```
