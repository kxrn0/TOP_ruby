def random_secret
  chars = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
  secret = []

  5.times do
    secret.push chars.sample
  end

  secret.join
end

def get_guess
  print "Enter a guess: "

  input = gets.chomp[0, 5]

  input
end

def play_again?
  message = "Do you wish to play again (y / n)?: "

  loop do
    print message
    response = gets.chomp.downcase

    if response == "y" || response == "n"
      return response == "y" ? true : false
    else
      message = "Invalid Input. Do you wish to play again (y / n): "
    end
  end
end

def init
  gameState = {}
  gameState[:secret] = random_secret
  gameState[:isPlaying] = true
  gameState[:maxLives] = 12
  gameState[:lives] = gameState[:maxLives]

  gameState
end

def anime(gameState)
  while gameState[:isPlaying]
    if gameState[:lives] == 0
      puts "Game Over. Ran out of lives."

      playAgain = play_again?

      if playAgain
        gameState = init
      else
        gameState[:isPlaying] = false
      end

      next
    end

    guess = get_guess

    if guess == gameState[:secret]
      puts "Correct. You won in #{gameState[:maxLives] - gameState[:lives] + 1} turns."

      playAgain = play_again?

      if playAgain
        gameState = init
      else
        gameState[:isPlaying] = false
      end
    else
      chars = guess.split ""

      print "#{guess} ... "
      chars.each_with_index do |char, index|
        if guess[index] == gameState[:secret][index]
          print "*"
        elsif gameState[:secret].include? guess[index]
          print "#"
        else
          print "-"
        end
      end

      puts "\nremaining lives: #{gameState[:lives] - 1}"

      gameState[:lives] -= 1
    end
  end
end

anime init
