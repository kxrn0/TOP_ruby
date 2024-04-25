class Game
  def initialize
    @max_turns = 7
    @secret = []
    @mistakes = 0
    @hits = []
    @is_playing = false
  end

  def self.get_secret
    size = File.open("words.txt") { |file| file.read.count "\n" } + 1
    number = rand size
    secret = []

    File.readlines("words.txt").each_with_index do |line, index|
      if number == index
        secret = line.chomp
        break
      end
    end

    secret.split ""
  end

  def set_up
    @secret = Game.get_secret
    @mistakes = 0
    @hits = []
    @is_playing = true
  end

  def print_board
    rope = @mistakes >= 1 ? "|" : " "
    head = @mistakes >= 2 ? "o" : " "
    torso = @mistakes >= 3 ? "|" : " "
    left_arm = @mistakes >= 4 ? "/" : " "
    right_arm = @mistakes >= 5 ? "\\" : " "
    left_leg = @mistakes >= 6 ? "/" : " "
    right_leg = @mistakes >= 7 ? "\\" : " "
    text = @secret.map do |char|
      if char == " " || @hits.include?(char)
        char
      else
        "_"
      end
    end.join "."

    puts "
    _____
    |   #{rope}
    |   #{head}
    |  #{left_arm}#{torso}#{right_arm}
    |  #{left_leg} #{right_leg}
    |
    "
    puts text
  end

  def get_guess
    message = "Enter guess, or 'exit' to end the game: "
    badInput = true

    while badInput
      print message

      input = gets.chomp.downcase

      if input.size == 1
        if @secret.include? input
          if @hits.include? input
            @mistakes += 1
          else
            @hits.push input
          end
        else
          @mistakes += 1
        end

        badInput = false
      elsif input == "exit"
        badInput = false
        @is_playing = false
      else
        message = "Invalid input. Please enter a guess, or 'exit' to end the game: "
      end
    end
  end

  def has_won
    @secret.all? { |c| @hits.include? c }
  end

  def play_again?
    message = "Play again (y / n)?: "
    badInput = true

    while badInput
      print message

      input = gets.chomp.downcase

      if input == "y"
        set_up
        badInput = false
      elsif input == "n"
        @is_playing = false
        badInput = false
      else
        message = "Invalid input. Play again (y / n)?: "
      end
    end
  end

  def play
    set_up

    while @is_playing
      print_board

      if @mistakes == @max_turns
        puts "Game over, the word was #{@secret.join}"

        play_again?
      elsif has_won
        puts "You won!"

        play_again?
      else
        get_guess
      end
    end
  end
end

game = Game.new

game.play
