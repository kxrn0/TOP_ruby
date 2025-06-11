# frozen-string-literal: true

require_relative 'coder'

class Player
  attr_accessor :lives

  def initialize
    @lives = Coder::MAX_MISTAKES
  end

  def enter_input
    options = [] - []

    done = false

    input = gets.downcase until done
  end
end
