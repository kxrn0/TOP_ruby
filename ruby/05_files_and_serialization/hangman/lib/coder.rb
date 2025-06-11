# frozen-string-literal: true

# Chooses the secred word, and provides hints.
class Coder
  attr_reader :available

  CHARS = [
    %w[q w e r t y u i o p],
    %w[a s d f g h j k l],
    %w[z x c v b n m]
  ].freeze

  def initialize
    @secret = 'word'
    @available = CHARS.clone.flatten
    @hits = []
    @misses = []
  end

  def guess(char)
    @available = @available.filter { |c| c != char }

    if @secret.incude? char
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
      '+'
    elsif @misses.include? acter
      '-'
    else
      acter
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
