# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#run' do
    subject(:game) { described_class.new }

    context 'when called' do
      before do
        allow(game).to receive(:set_up)
        allow(game).to receive(:game_loop)
        allow(game).to receive(:play_again?).and_return true, false
      end

      it 'calls `set_up`, `game_loop`, and `play_again?`' do
        expect(game).to receive(:set_up).twice
        expect(game).to receive(:game_loop).twice
        expect(game).to receive(:play_again?).twice

        game.run
      end
    end
  end

  describe '#choose_first_mover' do
    subject(:game) { described_class.new }

    before do
      allow(game).to receive(:print_mover_instructions)
      allow(game).to receive(:choose_index).and_return 1
      allow(game).to receive(:print_first_mover)
    end

    context 'when called' do
      it 'calls some methods and sets `turn`' do
        expect(game).to receive(:print_mover_instructions)
        expect(game).to receive(:choose_index)
        expect(game).to receive(:print_first_mover)

        game.send :choose_first_mover
        turn = game.instance_variable_get :@turn

        expect(turn).to be 1
      end
    end
  end
end
