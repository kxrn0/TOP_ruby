# frozen_string_literal: true

# Player
class Player
  def random_number
    rand 100
  end
end

# Game
class Game
  def initialize
    @player = Player.new
  end

  def fun
    number = @player.random_number

    if number == 50
      puts '!'
    else
      puts '...'
    end

    puts "player's rnd: #{number}"
  end
end

describe Game do
  subject(:game) { described_class.new }

  describe '#fun' do
    before do
      allow(game).to receive(:puts).twice
    end

    context 'when 50' do
      before do
        player = game.instance_variable_get :@player
        allow(player).to receive(:random_number).and_return 50
      end

      it 'outputs !' do
        expect(game).to receive(:puts).with '!'

        game.fun
      end
    end
  end
end
