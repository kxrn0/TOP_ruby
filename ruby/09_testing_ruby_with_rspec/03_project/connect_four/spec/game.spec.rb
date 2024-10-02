require_relative '../lib/game'

describe Game do
  # ...
  subject(:game) { described_class.new }

  describe '#reset' do
  end

  describe '#player_input' do
    let (:choices) { ['a', 'b', 'c'] }
    let (:prompt) { 'Enter choice > ' }
    let(:error) { 'wrong choice, try again' }

    context 'when the user enters a valid input' do
      before do
        allow(game).to receive(:gets).and_return("a\n")
      end

      it 'return it' do
        expected_output = 'a'

        result = game.player_input choices, prompt, error

        expect(result).to eq(expected_output)
      end
    end

    context 'when the user enters invalid input' do
      before do
        allow(game).to receive(:gets).and_return("me\n", "you\n", "a\n")
      end

      it 'complains, and reprompts the user until they enter something valid' do
        expected_output = 'a'

        expect(game).to receive(:print).exactly(3).times.with(prompt)
        expect(game).to receive(:puts).twice.with(error)

        result = game.player_input choices, prompt, error

        expect(result).to eq(expected_output)
      end
      # more tests...
    end
  end
  # ...
end
