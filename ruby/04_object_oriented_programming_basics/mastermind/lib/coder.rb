# frozen-string-literal: true

require_relative 'hints'

# The player that creates the codes, and provides hints
class Coder
  CODE_SIZE = 4

  PEGS = %w[a b c d e f].freeze

  attr_reader :code

  def initialize
    @code = ''
  end

  def hints(guess)
    pluses = compute_pluses guess
    minuses = compute_minuses guess

    Hints.new pluses, minuses
  end

  private

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
end
