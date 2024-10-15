require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#initialize' do
    context 'when the game is created with the default parameters' do
      it 'it has the defalt values' do
        expected_width = 9
        expected_height = 6
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

      it 'returns it' do
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

  describe '#resize_board' do
    before do
      allow(game).to receive(:change_dimension)
      allow(game).to receive(:reset_board)
    end

    context 'when the user wants to resize' do
      before do
        allow(game).to receive(:resize?).and_return (true)
      end

      it 'let them through' do
        expect(game).to receive(:change_dimension).twice
        expect(game).to receive(:reset_board).once

        game.resize_board
      end
    end

    context "when the user doesn't want to resize" do
      before do
        allow(game).to receive(:resize?).and_return (false)
      end

      it "doesn't" do
        expect(game).not_to receive(:change_dimension)
        expect(game).not_to receive(:reset_board)

        game.resize_board
      end
    end
  end

  describe '#valid_columns' do
    subject(:game) { Game.new 6, 7 }

    context 'when fed a board' do
      before do
        board = [
          nil, nil, nil, 'x', nil, 'o',
          nil, nil, 'x', 'o', nil, 'x',
          nil, nil, 'o', 'x', nil, 'o',
          nil, nil, 'x', 'o', nil, 'x',
          nil, 'o', 'o', 'x', nil, 'o',
          nil, 'x', 'o', 'x', nil, 'x',
          'o', 'x', 'o', 'x', 'o', 'x'

        ]

        game.instance_variable_set(:@board, board)
      end

      it 'returns only the columns the user can put a stone in' do
        expected_columns = %w[0 1 2 4]

        columns = game.valid_columns

        expect(columns).to eq(expected_columns)
      end
    end

    context 'when given a full board' do
      before do
        board = [
          'x', 'o', 'x', 'o', 'x', 'o',
          'o', 'x', 'o', 'x', 'o', 'x',
          'o', 'x', 'o', 'x', 'o', 'x',
          'o', 'x', 'o', 'x', 'o', 'x',
          'x', 'o', 'x', 'o', 'x', 'o',
          'x', 'o', 'x', 'o', 'x', 'o',
          'x', 'o', 'x', 'o', 'x', 'o'
        ]

        game.instance_variable_set(:@board, board)
      end

      it 'returns an empty array' do
        expect(game.valid_columns).to be_empty
      end
    end
  end

  describe '#compute_index' do
    subject(:game) { Game.new 6, 7 }
    let (:columns) { [0, 1, 2, 4] }
    let(:expected) { [30, 19, 2, 34] }

    before do
      board = [
        nil, nil, nil, 'x', nil, 'o',
        nil, nil, 'x', 'o', nil, 'x',
        nil, nil, 'o', 'x', nil, 'o',
        nil, nil, 'x', 'o', nil, 'x',
        nil, 'o', 'o', 'x', nil, 'o',
        nil, 'x', 'o', 'x', nil, 'x',
        'o', 'x', 'o', 'x', 'o', 'x'
      ]

      game.instance_variable_set(:@board, board)
    end

    context 'when the user chooses a column' do
      it 'returns the index the stone falls in' do
        columns.each_with_index do |column, index|
          expect(game.compute_index column).to eq(expected[index])
        end
      end
    end
  end

  describe '#turn order' do
    subject(:game) { Game.new 6, 7 }

    before do
      board = [
        nil, nil, nil, 'x', nil, 'o',
        nil, nil, 'x', 'o', nil, 'x',
        nil, nil, 'o', 'x', nil, 'o',
        nil, nil, 'x', 'o', nil, 'x',
        nil, 'o', 'o', 'x', nil, 'o',
        nil, 'x', 'o', 'x', nil, 'x',
        'o', 'x', 'o', 'x', 'o', 'x'
      ]

      game.instance_variable_set(:@board, board)
      game.instance_variable_set(:@current_player_index, 1)

      allow(game).to receive(:player_input).and_return('1')
    end

    context 'when the user makes a move' do
      it 'updates the board, and changes the turn to the next player' do
        expected_board = [
          nil, nil, nil, 'x', nil, 'o',
          nil, nil, 'x', 'o', nil, 'x',
          nil, nil, 'o', 'x', nil, 'o',
          nil, 'o', 'x', 'o', nil, 'x',
          nil, 'o', 'o', 'x', nil, 'o',
          nil, 'x', 'o', 'x', nil, 'x',
          'o', 'x', 'o', 'x', 'o', 'x'
        ]
        expected_index = 0

        expect(game).to receive(:puts)

        game.turn_order

        board = game.instance_variable_get(:@board)
        index = game.instance_variable_get(:@current_player_index)

        expect(board).to eq(expected_board)
        expect(index).to eq(expected_index)
      end
    end
  end

  describe '#check_x' do
    let(:wins) {
      [
        {
          board: [
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            'o', 'o', 'o', nil, nil, nil, nil, nil, nil,
            'x', 'x', 'x', 'x', nil, nil, nil, nil, nil
          ],
          winner: 'x'
        }, {
          board: [
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, 'x', nil, nil, nil, nil, nil, nil,
            'x', 'x', 'x', 'o', 'x', 'o', 'o', 'o', 'o',
            'x', 'o', 'x', 'o', 'x', 'o', 'x', 'o', 'x',
            'o', 'x', 'o', 'x', 'o', 'x', 'o', 'x', 'o'
          ],
          winner: 'o'
        },
        {
          board: [
            'x', nil, nil, nil, nil, nil, nil, nil, 'o',
            'o', nil, nil, nil, 'x', nil, nil, nil, 'x',
            'x', 'x', 'o', 'o', 'o', 'o', nil, nil, 'o',
            'o', 'o', 'o', 'x', 'o', 'x', 'x', nil, 'x',
            'x', 'x', 'o', 'x', 'o', 'x', 'o', 'o', 'o',
            'o', 'o', 'x', 'x', 'x', 'o', 'x', 'x', 'x'
          ],
          winner: 'o'
        },
        {
          board: [
            nil, nil, nil, nil, nil, 'o', 'o', 'o', 'o',
            nil, nil, nil, nil, nil, 'o', 'x', 'o', 'x',
            nil, nil, nil, nil, nil, 'o', 'x', 'o', 'x',
            nil, nil, nil, nil, nil, 'x', 'o', 'x', 'o',
            nil, nil, nil, nil, nil, 'o', 'o', 'x', 'o',
            'x', 'x', 'x', nil, 'x', 'x', 'x', 'o', 'x'
          ],
          winner: 'o'
        }
      ]
    }

    context 'when queried with boards with a horizontal winner' do
      it 'returns the correct winner each time' do
        wins.each do |win|
          expected_winner = win[:winner]

          game.instance_variable_set(:@board, win[:board])

          winner = game.check_x

          expect(winner).to eq(expected_winner)
        end
      end
    end
  end

  describe '#check_y' do
    let(:wins) {
      [
        {
          board: [
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            'x', nil, nil, nil, nil, nil, nil, nil, nil,
            'x', 'o', nil, nil, nil, nil, nil, nil, nil,
            'x', 'o', nil, nil, nil, nil, nil, nil, nil,
            'x', 'o', nil, nil, nil, nil, nil, nil, nil
          ],
          winner: 'x'
        },
        {
          board: [
            nil, nil, nil, nil, 'x', nil, nil, nil, nil,
            nil, nil, nil, nil, 'x', nil, nil, nil, nil,
            nil, nil, nil, nil, 'x', nil, nil, nil, nil,
            nil, nil, nil, 'o', 'x', nil, nil, nil, nil,
            nil, nil, nil, 'o', 'o', 'x', nil, nil, nil,
            nil, nil, nil, 'o', 'x', 'o', nil, nil, nil
          ],
          winner: 'x'
        },
        {
          board: [

            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, 'o',
            nil, nil, nil, nil, nil, nil, nil, nil, 'o',
            nil, nil, nil, nil, nil, nil, 'x', 'x', 'o',
            nil, nil, nil, nil, nil, nil, 'x', 'x', 'o'
          ],
          winner: 'o'
        },
        {
          board: [
            nil, nil, nil, nil, nil, nil, nil, nil, 'x',
            nil, nil, nil, nil, nil, nil, nil, nil, 'x',
            nil, nil, nil, nil, nil, nil, nil, nil, 'x',
            nil, nil, nil, nil, nil, nil, nil, nil, 'x',
            nil, nil, nil, nil, nil, nil, nil, 'o', 'o',
            nil, nil, nil, nil, 'o', 'o', 'o', 'x', 'x'
          ],
          winner: 'x'
        }

      ]
    }

    context 'when queried with boards with a vertical winner' do
      it 'returns the correct winner each time' do
        wins.each do |win|
          expected_winner = win[:winner]

          game.instance_variable_set(:@board, win[:board])

          winner = game.check_y

          expect(winner).to eq(expected_winner)
        end
      end
    end
  end

  describe '#check_diagonal' do
    let(:wins) {
      [
        {
          board: [

            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, 'x', nil, nil, nil,
            nil, nil, nil, nil, nil, 'o', 'x', nil, nil,
            nil, nil, nil, nil, nil, 'x', 'o', 'x', 'o',
            nil, nil, nil, nil, nil, 'o', 'x', 'o', 'x'
          ],
          winner: 'x'
        },
        {
          board: [

            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, 'x', nil, nil, nil, nil, nil,
            nil, nil, 'x', 'x', 'o', nil, nil, nil, nil,
            nil, 'x', 'x', 'o', 'o', nil, nil, nil, nil,
            'x', 'o', 'o', 'o', 'x', nil, nil, nil, nil
          ],
          winner: 'x'
        },
        {
          board: [

            nil, nil, nil, nil, nil, nil, nil, nil, 'o',
            nil, nil, nil, nil, nil, nil, nil, 'o', 'x',
            nil, nil, nil, nil, nil, nil, 'o', 'x', 'o',
            nil, nil, nil, nil, nil, 'o', 'o', 'o', 'x',
            nil, nil, nil, nil, nil, 'x', 'x', 'o', 'x',
            nil, nil, nil, 'x', 'x', 'o', 'x', 'o', 'x'

          ],
          winner: 'o'
        },
        {
          board: [
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, 'o', nil, nil,
            nil, nil, nil, 'x', nil, 'o', 'o', nil, nil,
            nil, nil, nil, 'x', 'o', 'x', 'o', nil, nil,
            nil, nil, nil, 'o', 'x', 'x', 'x', nil, nil,
            nil, nil, nil, 'x', 'x', 'o', 'o', nil, nil
          ],
          winner: 'o'
        }

      ]
    }

    context 'when queried with boards with a diagonal winner' do
      xit 'returns the correct result each time' do
        wins.each do |win|
          expected_winner = win[:winner]

          game.instance_variable_set(:@board, win[:board])

          winner = game.check_diagonal

          expect(winner).to eq(expected_winner)
        end
      end
    end
  end

  describe '#compute_winner' do
    let(:wins) {
      [
        {
          board: [
            nil, nil, nil, nil, nil, 'o', 'o', 'o', 'o',
            nil, nil, nil, nil, nil, 'o', 'x', 'o', 'x',
            nil, nil, nil, nil, nil, 'o', 'x', 'o', 'x',
            nil, nil, nil, nil, nil, 'x', 'o', 'x', 'o',
            nil, nil, nil, nil, nil, 'o', 'o', 'x', 'o',
            'x', 'x', 'x', nil, 'x', 'x', 'x', 'o', 'x'
          ],
          winner: 'o'
        },
        {
          board: [
            nil, nil, nil, nil, 'x', nil, nil, nil, nil,
            nil, nil, nil, nil, 'x', nil, nil, nil, nil,
            nil, nil, nil, nil, 'x', nil, nil, nil, nil,
            nil, nil, nil, 'o', 'x', nil, nil, nil, nil,
            nil, nil, nil, 'o', 'o', 'x', nil, nil, nil,
            nil, nil, nil, 'o', 'x', 'o', nil, nil, nil
          ],
          winner: 'x'
        },
        {
          board: [

            nil, nil, nil, nil, nil, nil, nil, nil, 'o',
            nil, nil, nil, nil, nil, nil, nil, 'o', 'x',
            nil, nil, nil, nil, nil, nil, 'o', 'x', 'o',
            nil, nil, nil, nil, nil, 'o', 'o', 'o', 'x',
            nil, nil, nil, nil, nil, 'x', 'x', 'o', 'x',
            nil, nil, nil, 'x', 'x', 'o', 'x', 'o', 'x'

          ],
          winner: 'o'
        },
        {
          board: [
            nil, nil, nil, 'o', 'x', nil, nil, nil, nil,
            nil, nil, nil, 'x', 'x', 'o', 'x', nil, nil,
            nil, nil, nil, 'x', 'o', 'o', 'o', nil, nil,
            nil, nil, nil, 'x', 'o', 'x', 'o', nil, nil,
            nil, nil, nil, 'o', 'x', 'x', 'x', 'o', nil,
            nil, nil, nil, 'x', 'x', 'o', 'o', 'x', nil
          ],
          winner: nil
        },
        {
          board: [
            'o', 'x', nil, 'o', 'x', nil, 'o', 'x', nil,
            'x', 'o', nil, 'x', 'o', nil, 'x', 'o', nil,
            'o', 'x', nil, 'o', 'x', nil, 'o', 'x', nil,
            'x', 'o', nil, 'x', 'o', nil, 'x', 'o', nil,
            'o', 'x', nil, 'o', 'x', nil, 'o', 'x', nil,
            'x', 'o', nil, 'x', 'o', nil, 'x', 'o', nil
          ],
          winner: nil
        },
        {
          board: [
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, 'x', nil, nil, nil, nil,
            nil, nil, nil, 'o', 'x', 'o', nil, nil, nil
          ],
          winner: nil
        },
        {
          board: [
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil, nil
          ],
          winner: nil
        }
      ]
    }

    context 'when queried with boards with or without a winner' do
      it 'returns the correct result each time' do
        wins.each do |win|
          expected_winner = win[:winner]

          game.instance_variable_set(:@board, win[:board])

          winner = game.compute_winner

          expect(winner).to eq(expected_winner)
        end
      end
    end
  end
end
