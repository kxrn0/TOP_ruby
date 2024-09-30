require_relative '../lib/game'

describe Game do
  describe '' do
    context '' do
      it '' do
      end
    end
  end

  describe '#player_input' do
    subject(:game) { described_class.new }

    before do
      bad_input1 = 'x'
      bad_input2 = 'y'
      good_input = 'b'
      allow(game).to receive(:gets).and_return(bad_input1, bad_input2, good_input)
    end

    context 'lets the user choose from a fixed selection' do
      it 'returns when the user selects a valid input' do
        prompt = "Enter either of 'a', 'b', or 'c' > "
        error = 'Invalid input!'
        choices = %w[a b c]
        sane_choice = 'b'

        expect(game).to receive(:puts).twice
        expect(game).to receive(:print).exactly(3).times

        user_choice = game.player_input(choices, prompt, error)

        expect(user_choice).to eq(sane_choice)
      end
    end
  end

  describe '#enter_marker' do
    subject(:game) { described_class.new }

    context 'when the first user enters a valid marker' do
      before do
        allow(game).to receive(:gets).and_return("\n", "x\n")
      end

      it 'returns it' do
        id = 'a'
        prompt = "Enter player #{id}'s marker: "
        error = 'Please choose a different marker!'
        correct_input = 'x'

        expect(game).to receive(:print).twice.with(prompt)
        expect(game).to receive(:puts).once.with(error)

        result = game.enter_marker(id)

        expect(result).to eq(correct_input)
      end
    end

    context 'when it\'s time for the second user to enter a marker' do
      before do
        allow(game).to receive(:gets).and_return("x\n", "o\n")
      end

      it 'doesn\'t let them enter the previous one' do
        id = 'b'
        prompt = "Enter player #{id}'s marker: "
        error = 'Please choose a different marker!'
        prev_input = 'x'
        correct_input = 'o'

        expect(game).to receive(:print).twice.with(prompt)
        expect(game).to receive(:puts).once.with(error)

        result = game.enter_marker(id, prev_input)

        expect(result).to eq(correct_input)
      end
    end
  end

  describe '#fun' do
    context '' do
      it '' do
      end
    end
  end
end
