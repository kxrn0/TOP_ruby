# frozen-string-literal: true

require_relative 'coder'
require_relative 'game'

# Automatic guesser
class AIGuesser
  def initialize(game)
    @game = game
  end

  def guess
    guess = ''

    Coder::CODE_SIZE.times { guess += Coder::PEGS.sample }

    puts "\nGUESS (#{@game.guesses} / #{Game::INIT_GUESSES}): #{guess}"

    guess
  end

  def give(hints)
    puts "ANALYZING [ #{hints}]..."
    sleep 1
  end
end
