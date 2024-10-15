# Connect four

## Gameplay

The game will have two players, each with their own identifiable marker, which will be `x` and `o`. The program will first ask the players who should go first, and it will expect a player to enter one of the markers.

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

That column is unavailable! please choose a different one!

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

## Implementation Details

How do I find if someone has won? I need an algorithm to check that. I will divide it into three parts; checking if someone has won with a horizontal, vertical, or diagonal arrangement, so the function to compute the winner will look like this

```
function compute_winner {
    return check_horizontal || check_vertical || check_diagonal
}
```

### check_horizontal

To check if there's a winner horizontally I think I will go row by row, cell by cell. So the algorithm could be like this:

```
function check_horizontal {
    winner = nil
    count = 0

    for y = 0; y < rows; y++ {
        winner = nil
        count = 0

        for x = 0; x < cols; x++ {
            index = x + y * cols
            char = board[index]

            if char == winner
                count++
            else {
                winner = char
                count = 1
            }

            if count == 4 && winner
                return winner
        }
    }

    if count >= 4 && winner
        return winner
    nil
}
```

I think the method for checking if someone has won with a verticall arrangement would be similar.

```
function check_vertical {
    winner = nil
    count = 0

    for x = 0; x < cols; x++ {
        winner = nil
        count = 0

        for y = 0; y < rows; y++ {
            index = x + y * cols
            char = board[index]

            if char == winner
                count++
            else {
                winner = char;
                count = 1
            }

            if count == 4 && winner
                return winner
        }

    }

    if count >= 4 && winner
        return winner

    nil
}
```

Mayhaps I could combine them and use a singular function for this

```
function check_axis a, b, idx {
    winner = nil
    count = 0

    for i = 0; i < a; i++ {
        winner = nil
        count = 0

        for j = 0; j < b; j++ {
            index = idx i, j
            char = board[index]

            if char == winner
                count++
            else {
                winner = char
                count = 1
            }

            if count >= 4 && winner
                return winner
        }
    }

    if count >= 4 && winner
        return winner

    nil
}

function check_x {
    idx = (y, x) => x + y * cols

    check_axis rows, cols, idx
}

function check_y {
    idx = (x, y) => x + y * cols

    check_axis cols, rows, idx
}
```

How do I find if someone has won with a diagonal arrangement? I think I should go cell by cell horizontally, and for each cell see if the next one stepping down to the right has the same value, if so, I do the same for that cell, and so on. If not, then I check if the one stepping down to the left has the same value, and so on. If not, I move to the next cell.

```
function cb(x0, y0, condx, pdtx) {
    idx = x0 + y0 * cols
    char = board[idx]
    winner = char

    for xi = x0; cond xi; xi = pdt xi {
        for yi = y0; yi < y0 + 4 && yi < rows; yi++ {
            idx = xi + yi * cols
            char = board[idx]

            unless char && char == winner
                return nil
        }
    }

    winner
}

function check_diagonal {
    winner = nil
    count = 0

    for x = 0; x < cols; x++ {
        for y = 0; y < rows; y++ {
            index = x + y * cols
            char = board[index]

            next unless char

            cond_r = xi => xi < x + 4 && xi < cols
            pdt_r = xi => x + 1
            res = cb x, y, cond_r, ptd_r

            return res if res

            cond_l = xi => xi > x - 4 && xi >= 0
            pdt_l = xi => xi - 1
            res = cb x, y, cond_l, pdt_l

            return res if res
        }
    }
}
```
