# frozen-string-literal: true

# Chooses the secred word, and provides hints.
class Coder
  attr_reader :available, :secret

  CHARS = [
    %w[q w e r t y u i o p],
    %w[a s d f g h j k l],
    %w[z x c v b n m]
  ].freeze

  MAX_MISTAKES = 8

  def hydrate(data)
    @secret = data['secret']
    @available = data['available']
    @hits = data['hits']
    @misses = data['misses']
  end

  def initialize(game)
    @secret = game.file_manager.select_random_word
    @available = CHARS.clone.flatten
    @hits = []
    @misses = []
  end

  def to_h
    { secret: @secret, available: @available, hits: @hits, misses: @misses }
  end

  def guessed?
    guess = hints_to_s.split(' ').join

    @secret == guess
  end

  def guess(char)
    @available = @available.filter { |c| c != char }

    if @secret.include? char
      @hits.push char

      true
    else
      @misses.push char

      false
    end
  end

  def keyboard_to_s
    stroard = ''

    CHARS.each_with_index do |row, index|
      stroard += row_to_s row, index
      stroard += "\n"
    end

    stroard
  end

  def hints_to_s
    @secret.split('').reduce('') do |acc, curr|
      acc += if @hits.include? curr
               " #{curr}"
             else
               ' _'
             end

      acc
    end
  end

  private

  def choose_char(acter)
    if @hits.include? acter
      ' + '
    elsif @misses.include? acter
      ' - '
    else
      " #{acter} "
    end
  end

  def row_to_s(row, index)
    strow = ' ' * index

    row.each do |char|
      strow += choose_char char
    end

    strow
  end
end
