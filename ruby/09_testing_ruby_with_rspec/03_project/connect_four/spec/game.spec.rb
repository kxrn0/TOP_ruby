require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#initialize' do
    context 'when the game is created with the default parameters' do
      it 'it has the defalt values' do
        expected_width = 6
        expected_height = 9
        expected_board = Array.new expected_width * expected_height
        width = game.instance_variable_get(:@width)
        height = game.instance_variable_get(:@height)
        board = game.instance_variable_get(:@board)

        expect(width).to eq(expected_width)
        expect(height).to eq(expected_height)
        expect(board).to eq(expected_board)
      end
    end
  end

  describe '#reset' do
    context 'when called' do
      before do
        board = [
          nil, nil, nil, nil, nil, nil, nil, nil, nil,
          nil, nil, nil, nil, nil, nil, nil, nil, nil,
          nil, nil, nil, 'o', nil, nil, nil, nil, nil,
          nil, nil, nil, 'o', 'x', nil, nil, nil, nil,
          nil, nil, nil, 'o', 'x', nil, nil, nil, nil,
          nil, nil, nil, 'o', 'x', nil, nil, nil, nil
        ]

        game.instance_variable_set(:@width, 9)
        game.instance_variable_set(:@height, 6)
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@winner, 'o')
        game.instance_variable_set(:@current_player_index, 0)
        game.instance_variable_set(:@is_playing, false)
      end

      it 'resets' do
        expected_width = 10
        expected_height = 10
        expected_board = Array.new expected_width * expected_height
        expected_winner = nil
        expected_index = 0
        expected_play_state = true

        game.reset expected_width, expected_height

        expect(game.instance_variable_get(:@width)).to eq(expected_width)
        expect(game.instance_variable_get(:@height)).to eq(expected_height)
        expect(game.instance_variable_get(:@board)).to eq(expected_board)
        expect(game.instance_variable_get(:@current_player_index)).to eq(expected_index)
        expect(game.instance_variable_get(:@winner)).to eq(expected_winner)
        expect(game.instance_variable_get(:@is_playing)).to eq (expected_play_state)
      end
    end
  end

  describe '#reset_board' do
    context 'when the board is reset' do
      before do
        game_board = [
          nil, nil, nil, nil, nil, nil, nil, nil, nil,
          nil, nil, nil, nil, nil, nil, nil, nil, nil,
          nil, nil, nil, 'o', nil, nil, nil, nil, nil,
          nil, nil, nil, 'o', 'x', nil, nil, nil, nil,
          nil, nil, nil, 'o', 'x', nil, nil, nil, nil,
          nil, nil, nil, 'o', 'x', nil, nil, nil, nil
        ]

        game.instance_variable_set(:@board, game_board)
      end

      it 'is emptied' do
        width = game.instance_variable_get(:@width)
        height = game.instance_variable_get(:@height)
        expected_board = Array.new width * height

        game.reset_board

        board = game.instance_variable_get(:@board)

        expect(board).to eq(expected_board)
      end
    end
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

        expect(game).to receive(:print).with(prompt).once
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
    end
  end

  describe '#yes_or_no?' do
    let(:prompt) { '(y / n)? > ' }
    context "when the user enters 'y'" do
      before do
        allow(game).to receive(:player_input).and_return('y')
      end

      it 'returns true' do
        expect(game.yes_or_no? prompt).to eq(true)
      end
    end

    context "when the user enters 'n'" do
      before do
        allow(game).to receive(:player_input).and_return('n')
      end

      it 'returns false' do
        expect(game.yes_or_no? prompt).to eq(false)
      end
    end
  end

  describe '#choose_turns' do
    context 'when x goes first' do
      before do
        allow(game).to receive(:player_input).and_return('x')
      end

      it 'the current player index is expected to be zero' do
        expected_index = 0

        game.choose_turns

        index = game.instance_variable_get(:@current_player_index)

        expect(index).to eq(expected_index)
      end
    end

    context 'when o goes first' do
      before do
        allow(game).to receive(:player_input).and_return('o')
      end

      it 'the current player index is expected to be one' do
        expected_index = 1

        game.choose_turns

        index = game.instance_variable_get(:@current_player_index)

        expect(index).to eq(expected_index)
      end
    end
  end

  describe '#change_dimension' do
    context "when called with 'width'" do
      let (:new_width) { 10 }

      before do
        str = new_width.to_s
        allow(game).to receive(:player_input).and_return(str)
      end

      it 'changes the `@width`' do
        var = 'width'
        game.change_dimension var
        width = game.instance_variable_get(:@width)

        expect(width).to eq(new_width)
      end
    end
  end

  describe '#turn order' do
  end
end
