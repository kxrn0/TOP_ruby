# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#set_up' do
    before do
      allow(game).to receive(:sleep)
      allow(game).to receive(:puts).exactly(3).times
    end

    context 'when the method is called' do
      it 'sets the values of the instance variables to the correct types' do
        game.send(:set_up)
        board = game.instance_variable_get(:@board)
        turn = game.instance_variable_get(:@turn)
        is_gaming = game.instance_variable_get(:@is_gaming)

        expect(board).to be_instance_of(Board)
        expect(turn).to be_between(0, 1).inclusive
        expect(is_gaming).to be true
      end
    end

    context 'when the turn is 1' do
      before do
        allow(game).to receive(:rand).and_return 1
      end

      it 'o goes first' do
        message = "\n「o」 goes first\n"

        expect(game).to receive(:puts).with message

        game.send(:set_up)
      end
    end
  end

  describe '#terminate' do
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:sleep)

      game.send :set_up
    end

    context 'when the method is called' do
      it 'terminates things' do
        game.send :terminate
        is_gaming = game.instance_variable_get(:@is_gaming)
        is_running = game.instance_variable_get(:@is_running)

        expect(is_gaming).to be false
        expect(is_running).to be false
      end
    end
  end

  describe '#handle_input' do
    before do
      allow(game).to receive(:terminate)
      allow(game).to receive(:update_board)
    end

    context 'when the input is `exit`' do
      before do
        allow(game).to receive(:obtain_user_input).and_return 'exit'
      end

      it 'terminates' do
        expect(game).to receive(:terminate)

        game.send :handle_input
      end
    end

    context 'when the input is something else' do
      before do
        allow(game).to receive(:obtain_user_input).and_return '5'
      end

      it 'updates the board' do
        expect(game).to receive(:update_board)

        game.send :handle_input
      end
    end
  end

  describe '#update_winner' do
    context 'when x wins' do
      it 'increase its score by one' do
        expect { game.send :update_winner, 'x' }.to change { game.instance_variable_get(:@players)[0].wins }.by 1
      end
    end
  end

  describe '#print_end_message' do
    before do
      allow(game).to receive(:print_scores)
    end

    context "when there's no winner" do
      it 'says that it is a tie' do
        message = "\n\nGAME OVER! it's a tie!"

        expect(game).to receive(:puts).with message

        game.send :print_end_message, nil
      end
    end

    context "when there's a winner" do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:update_winner)
      end

      it 'calls `update_winner`' do
        expect(game).to receive(:update_winner)

        game.send :print_end_message, 'x'
      end
    end
  end

  describe '#update' do
    context "when there's no winner" do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:sleep)

        game.send :set_up

        board = game.instance_variable_get :@board

        allow(board).to receive(:compute_winner).and_return nil
        allow(board).to receive(:full?).and_return false
      end

      it 'switch the turn' do
        expect { game.send :update }.to change { game.instance_variable_get :@turn }.by 1
      end
    end

    context "when there's a winner" do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:sleep)

        game.send :set_up

        board = game.instance_variable_get :@board

        allow(board).to receive(:compute_winner).and_return 'o'
        allow(board).to receive(:full?).and_return false
      end

      it 'stop gaming, and print the end message' do
        expect(game).to receive :print_end_message
        expect { game.send :update }.to change { game.instance_variable_get :@is_gaming }.to(false)
      end
    end
  end
end
