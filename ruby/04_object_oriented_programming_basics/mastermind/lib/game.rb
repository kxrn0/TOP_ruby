# frozen-string-literal: true

require_relative './inputable'

INTRO = <<~HEREDOC
  I created a four-letter code with the characters [a, b, c, d, e, f].
  Your task is to crack it.

  For every guess I'll provide some hints.

  A + means a letter is in the correct spot.
  A - means a letter is in the code, but in the wrong spot.

  You have 12 guesses.

  Enter a guess, or 'exit' to terminate the program (not recommended).

HEREDOC

CHOICES = %w[a b c d e f].freeze

CODE_SIZE = 4

INIT_GUESSES = 12

# mastermind game class
# call `start` to start the game
class Game
  include Inputable

  def initialize
    @code = ''
    @guesses = 0
    @running = true
  end

  def start
    puts INTRO

    reset
    game_loop
  end

  private

  def reset_code
    @code = ''

    CODE_SIZE.times { @code += CHOICES.sample }
  end

  def reset
    reset_code
    @guesses = INIT_GUESSES
  end

  def play_again?
    prompt = 'Play again (yes / no)? > '
    error_message = "Enter only 'yes' or 'no'!"
    options = %w[yes no]
    choice = get_input prompt, error_message, options

    @running = choice == 'yes'
  end

  def handle_game_over(won)
    result = won ? 'won' : 'lost'

    puts "\nGAME OVER! You #{result}!"

    puts "The code was #{@code}!" unless won

    choice = play_again?

    reset if choice

    @running = choice
  end

  def compute_pluses(guess)
    count = 0

    @code.size.times do |idx|
      count += 1 if guess[idx] == @code[idx]
    end

    count
  end

  def clear_pluses(guess)
    guess = guess.split ''
    code = @code.split ''

    code.size.times do |idx|
      code[idx] = guess[idx] = nil if code[idx] == guess[idx]
    end

    [guess, code]
  end

  def count_misses(guess, code)
    count = 0

    code.size.times do |idx|
      next if code[idx].nil?

      index = guess.index code[idx]

      unless index.nil?
        guess[index] = nil
        count += 1
      end
    end

    count
  end

  def compute_minuses(guess)
    guess, code = clear_pluses guess

    count_misses guess, code
  end

  def compute_hints(guess)
    pluses = compute_pluses guess
    minuses = compute_minuses guess

    "#{'+ ' * pluses}#{'-' * minuses}"
  end

  def give_hints(guess)
    hints = compute_hints guess
    puts "hints: #{hints}"
  end

  def act_on_input(input)
    if input == 'exit'
      @running = false
    elsif input == @code
      handle_game_over true
    else
      give_hints input
    end
  end

  def update
    @guesses -= 1

    return unless @guesses.zero?

    handle_game_over false
  end

  def receive_input
    print "enter guess (#{@guesses} / 12) > "
    gets.chomp
  end

  def game_loop
    while @running
      act_on_input receive_input if @guesses > 1
      update if @running
    end
  end
end
