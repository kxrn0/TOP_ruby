class Game
  @@winning_conds = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]

  def init
    set_up
    play
  end
  
  def get_marker id, prev = nil
    loop do
      print "Enter player #{id}'s marker: "
      marker = gets.chomp[0]

      if marker.nil? || marker == prev
        puts "Invalid input! Please try again!"
      else
        return marker
      end
    end
  end

  def set_up_markers
    @marker_a = get_marker 'a'
    @marker_b = get_marker 'b', @marker_a
  end

  def set_up_turns
    loop do
      print "Who goes first?\n(a) - #{@marker_a}\n(b) - #{@marker_b}\n> "
      first = gets.chomp[0]

      if first == 'a' || first == 'b'
        @players = [@marker_a, @marker_b]
        
        @players.rotate! if first == 'b'
        
        return
      else
        puts 'Invalid input! Enter either \'a\' or \'b\'.'
      end
    end
  end

  def set_up
    @board = Array.new 9
    @player_idx = 0
    @playing = true

    set_up_markers
    set_up_turns
  end

  def print_board
    puts "
         |     |
      #{@board[0] || ' '}  |  #{@board[1] || ' '}  |  #{@board[2] || ' '}
        0|    1|    2
    -----.-----.-----
         |     |
      #{@board[3] || ' '}  |  #{@board[4] || ' '}  |  #{@board[5] || ' '}
        3|    4|    5
    -----.-----.-----
         |     |
      #{@board[6] || ' '}  |  #{@board[7] || ' '}  |  #{@board[8] || ' '}
        6|    7|    8
    "
  end

  def get_cell
    reg = /^[0-8]$/
    
    loop do
      print "It's #{@players[@player_idx]}'s turn. Choose a cell: "
      cell = gets.chomp
      index = cell.to_i
      match = cell.match reg
      is_free = !@board[index]
      
      if match && is_free
        @board[index] = @players[@player_idx]

        return
      end

      puts 'Invalid input! Please enter a valid cell!'
    end
  end

  def board_full?
    @board.none? { |cell| cell.nil? }
  end
  
  def winner?
    @@winning_conds.any? do |cond|
      callback = ->(marker) { cond.all? { |idx| @board[idx] == marker } }

      callback.call(@marker_a) || callback.call(@marker_b)
    end
  end

  def next_index!
    @player_idx = 1 - @player_idx
  end
  
  def choose_path again
    if again
      set_up
    else
      @playing = false
    end
  end

  def play_again?
    loop do
      print "Play again (y / n)? : "
      again = gets.chomp.downcase
    
      return true if again == 'y'
      return false if again == 'n'
    end
  end

  def play
    while @playing do
      print_board

      if winner?
        puts "Player #{@players[next_index!]} wins!"

        choose_path play_again?
      elsif board_full?
        puts "Game Over! It's A Tie!"
        
        choose_path play_again?
      else
        get_cell
        next_index!
      end
    end
  end
end
