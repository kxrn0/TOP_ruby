require "json"
require "fileutils"

class Game
  def initialize
    @state = { max_mistakes: 7 }
    @is_on = true
  end

  def init_state
    @state[:is_playing] = true
    @state[:secret] = Game.get_secret
    @state[:mistakes] = 0
    @state[:hits] = []
  end

  def get_input(message, choices)
    while true
      print message
      input = gets.chomp

      if choices.include? input
        return input
      else
        puts "Invalid input! Try again!"
      end
    end
  end

  def sanitize(filename)
    fn = filename.split /(?<=.)\.(?=[^.])(?!.*\.[^.])/m
    fn.map! { |s| s.gsub /[^a-z0-9\-]+/i, "_" }

    return fn.join "."
  end

  def save_game
    Dir.mkdir "games" unless Dir.exist? "games"

    print "Enter game name: "
    name = gets.chomp
    date = Time.now.to_s.split.join "_"
    filename = "#{sanitize name}_#{date}.json"
    data = {
      secret: @state[:secret],
      mistakes: @state[:mistakes],
      hits: @state[:hits],
    }
    contents = JSON.dump data

    File.write "gme.txt", "#{filename}\n", mode: "a"
    File.write "games/#{filename}", contents

    puts "Game saved as #{filename}. Enter 'end' to end current game, or continue playing."
  end

  def get_guess
    bad_input = true
    help = "
      help -> Print help
      end -> End current game
      save -> Save current game
      exit -> Exit
    "

    while bad_input
      print "Enter guess, or 'help' for options: "
      input = gets.chomp.downcase

      if input.size == 1
        if (@state[:secret].include? input) && (!@state[:hits].include? input)
          @state[:hits].push input
        else
          @state[:mistakes] += 1
        end

        bad_input = false
      else
        case input
        when "help"
          puts help
        when "end"
          puts "Terminating current game..."
          @state[:is_playing] = false
          bad_input = false
        when "save"
          puts "Saving game..."
          save_game
        when "exit"
          @state[:is_playing] = false
          @is_on = false
          bad_input = false
        else
          puts "Invalid input! Try again!"
        end
      end
    end
  end

  def print_board
    rope = @state[:mistakes] >= 1 ? "|" : " "
    head = @state[:mistakes] >= 2 ? "o" : " "
    torso = @state[:mistakes] >= 3 ? "|" : " "
    left_arm = @state[:mistakes] >= 4 ? "/" : " "
    right_arm = @state[:mistakes] >= 5 ? "\\" : " "
    left_leg = @state[:mistakes] >= 6 ? "/" : " "
    right_leg = @state[:mistakes] >= 7 ? "\\" : " "
    text = @state[:secret].map do |char|
      if char == " " || @state[:hits].include?(char)
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

  def play_again
    input = get_input "Play again (yes / no)?: ", ["yes", "no"]

    if input == "yes"
      init_state
    elsif input == "no"
      @state[:is_playing] = false
    end
  end

  def play
    while @state[:is_playing]
      print_board

      if @state[:mistakes] >= @state[:max_mistakes]
        puts "Game over, the word was #{@state[:secret].join "."}."
        play_again
      elsif @state[:secret].all? { |char| @state[:hits].include? char }
        puts "You win!"
        play_again
      else
        get_guess
      end
    end
  end

  def get_number(min, max, bcond, message = "Enter a number: ")
    reg = /^\d+$/

    while true
      print message
      input = gets.chomp

      return nil if input == bcond

      n = input.to_i

      if (input.match reg) && (min <= n && n <= max)
        return n
      else
        puts "Invalid input! Try again!"
      end
    end
  end

  def remove_line(text, filename)
    ext = filename.split "."[-1]
    temp_name = "#{Time.now.to_f.to_s}.#{ext}"

    File.open(temp_name, "w") do |temp|
      File.foreach(filename) do |line|
        line = line.chomp

        temp.puts line unless line == text
      end
    end

    FileUtils.mv temp_name, filename
  end

  def delete_record(list, index, message)
    to_delete = list[index]

    list.filter! { |other| other != to_delete }

    remove_line to_delete, "gme.txt"
    puts message
  end

  def load_game
    unless File.exist? "gme.txt"
      return puts "No game list found!"
    end

    game_list = []
    File.foreach("gme.txt") { |line| game_list.push line.chomp }

    bad_input = true
    while bad_input
      game_list.each_with_index do |name, index|
        puts "#{index + 1} - #{name}"
      end

      print "Enter the index of a game, or 'menu' to go back: "
      index = get_number 1, game_list.size, "menu"

      unless index
        return puts "Back to main menu..."
      end

      index -= 1
      name = game_list[index]
      filename = "games/#{name}"
      exists = File.exist? filename

      unless exists
        delete_record game_list, index, "Game not found! Try another one!"
      else
        begin
          file = File.open filename
          data = JSON.parse file.read
        rescue
          File.delete filename
          delete_record game_list, index, "File corrupted! Try a different one!"

          next
        end

        if data["secret"].class == Array &&
           data["mistakes"].class == Integer &&
           data["hits"].class == Array
          input = get_input "play / delete / menu: ", ["play", "delete", "menu"]

          case input
          when "play"
            @state[:secret] = data["secret"]
            @state[:mistakes] = data["mistakes"]
            @state[:hits] = data["hits"]
            @state[:is_playing] = true
            bad_input = false
            play
          when "delete"
            File.delete filename
            delete_record game_list, index, "Game deleted."
          when "menu"
            bad_input = false
          end
        else
          delete_record game_list, index, "Game corrupted! Try another one!"
        end

        file.close
      end
    end
  end

  def start
    help = "
      help -> Print help
      new -> New Game!
      load -> Load game
      exit -> Exit
    "

    while @is_on
      puts "Instructions:"
      puts help

      option = get_input "Enter option: ", ["help", "new", "load", "exit"]

      case option
      when "new"
        init_state
        play
      when "load"
        load_game
      when "exit"
        @is_on = false
      end
    end
  end

  def self.get_secret
    size = File.open("words.txt") { |file| file.read.count "\n" } + 1
    number = rand size
    secret = nil

    File.readlines("words.txt").each_with_index do |line, index|
      if number == index
        secret = line.chomp
        break
      end
    end

    secret.split ""
  end
end

game = Game.new

game.start
