# frozen_string_literal: true

# Game class
class Game
  def do_thing
    puts 'A'
    # ...
    puts 'B'

    rnd = rand 10

    puts "the number is #{rnd}"
  end
end

describe Game do
  subject(:game) { described_class.new }

  describe '#do_thing' do
    before do
      allow(game).to receive(:puts).exactly(3).times
    end

    context 'when something' do
      # ...
    end

    context 'when something else' do
      before do
        allow(game).to receive(:rand).and_return 5
      end

      it 'does the thing' do
        message = 'the number is 5'
        expect(game).to receive(:puts).with message

        game.do_thing
      end
    end
  end
end
