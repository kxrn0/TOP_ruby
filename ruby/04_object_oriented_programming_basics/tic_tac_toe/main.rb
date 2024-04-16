def get_players
  badInput = true
  players = []

  while badInput
    print "Enter the first player, x, or o (enter 'exit' to end game): "
    playerOne = gets.chomp.downcase

    if playerOne == "x" || playerOne == "o"
      if playerOne == "x"
        playerTwo = "o"
      else
        playerTwo = "x"
      end

      players = [playerOne, playerTwo]
      badInput = false
    end

    if playerOne == "exit"
      players = [nil, nil]
      badInput = false
    end
  end

  players
end

def select_cell(turn, state)
  badInput = true
  message = "#{turn}'s turn. Enter cell number: "
  validInputs = Array.new(9) { |i| i.to_s }

  while badInput
    print message
    input = gets.chomp
    index = input.to_i

    if (validInputs.include? input) && (state[index] == " ")
      state[index] = turn
      badInput = false
    else
      message = "Invalid input, please enter a valid cell number for #{turn}: "
    end
  end
end

def print_board(state)
  puts "
       |     |
    #{state[0]}  |  #{state[1]}  |  #{state[2]}
      0|    1|    2
  -----.-----.-----
       |     |
    #{state[3]}  |  #{state[4]}  |  #{state[5]}
      3|    4|    5
  -----.-----.-----
       |     |
    #{state[6]}  |  #{state[7]}  |  #{state[8]}
      6|    7|    8
  "
end

def check_win(state)
  winning = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]

  winning.reduce(nil) do |winner, current|
    return winner if winner

    if (state[current[0]] == state[current[1]]) &&
       (state[current[1]] == state[current[2]])
      value = state[current[0]]

      unless value == " "
        return value
      end
    end
  end
end

def play_again?
  badInput = true
  message = "y / n: "
  playAgain = false

  while badInput
    print message
    input = gets.chomp.downcase

    if input == "y" || input == "n"
      playAgain = input == "y" ? true : false
      badInput = false
    else
      message = "Invalid input. Enter 'y' or 'n': "
    end
  end

  playAgain
end

def init
  players = get_players
  playerOne = players[0]
  playerTwo = players[1]
  isPlaying = playerOne ? true : false
  state = Array.new 9, " "
  turn = playerOne

  { playerOne: playerOne,
    playerTwo: playerTwo,
    isPlaying: isPlaying,
    state: state,
    turn: turn }
end

gameState = init

while gameState[:isPlaying]
  print_board gameState[:state]
  select_cell gameState[:turn], gameState[:state]
  winner = check_win gameState[:state]
  isFull = gameState[:state].none? { |cell| cell == " " }

  if isFull || winner
    print_board gameState[:state]

    if winner
      puts "It's #{gameState[:turn]}'s Victory."
    else
      puts "Board full. It's over."
    end

    print "Do you wish to play again? "
    playAgain = play_again?

    if playAgain
      gameState = init
    else
      gameState[:isPlaying] = false
    end
  else
    gameState[:turn] = gameState[:turn] == "x" ? "o" : "x"
  end
end
