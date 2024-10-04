Connect four. The game will have two players, each with their own identifiable marker, which will be `x` and `o`. The program will first ask the players who should go first, and it will expect a player to enter one of the markers.

```
Connect Four. Copyright kxrn0, 1966.

Who should go first (x / o)? >
```

If the player enters an invalid choice, they will be asked to enter something again.

```
Connect Four. Copyright kxrn0, 1966.

Who should go first (x / o)? > me

Invalid input! please enter a valid choice!

Who should go first (x / o)? >
```

The program will then state the board size, and ask if they want to change it.

```
Board size: 9 by 6. Do you wish to change it (y / n)? >
```

The smallest dimension for the board will be 6, while the largest will be 18.

```
Board size: 9 by 6. Do you wish to change it (y / n)? > y

Enter width (min: 6, max: 18) > 5

Invalid input! width has to be in [6, 18]! try again!

Enter width (min: 6, max: 18) > 7

Enter height (min: 6, max: 18) >
```

Once the players have decided who will go first, the game will start.

```
Who should go first (x / o)? > o

Board size: 9x6. Do you wish to change it (y / n)? > n

 _____ _____ _____ _____ _____ _____ _____ _____ _____
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |

It's o's turn! enter a column to insert the stone [0, 8] >
```

The current player is then expected to enter a valid column number.

```
It's o's turn! enter a column to insert the stone [0, 8] > 3

 _____ _____ _____ _____ _____ _____ _____ _____ _____
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  o  |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |


It's x's turn! enter a column to insert the stone [0, 8] >
```

If a user enters the index of a full column, they will be asked to enter again.

```
 _____ _____ _____ _____ _____ _____ _____ _____ _____
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |  o  |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  o  |  x  |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  x  |  o  |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  o  |  x  |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  o  |  x  |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  o  |  x  |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |


It's x's turn! enter a column to insert the stone [0, 8] > 4

That column is full! please choose a different one!

It's x's turn! enter a column to insert the stone [0, 8] >
```

The game is over when a player wins, or when the board is full. When the game is over, the players are asked if they want to play again.

```

It's o's turn! enter a column to insert the stone [0, 8] > 3

 _____ _____ _____ _____ _____ _____ _____ _____ _____
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  o  |     |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  o  |  x  |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  o  |  x  |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|     |     |     |  o  |  x  |     |     |     |     |
|_____|_____|_____|_____|_____|_____|_____|_____|_____|
|     |     |     |     |     |     |     |     |     |
|  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |

Game Over! o is the winner!

Do you wish to play again (y / n)? >
```

then the players can choose to play or end the game

```
Do you wish to play again (y / n)? > y

Who should go first (x / o)? >
```

or

```
Do you wish to play again (y / n)? > n
```
