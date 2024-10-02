require_relative '../lib/game'

describe Game do
  describe '' do
    context '' do
      it '' do
      end
    end
  end

  subject(:game) { described_class.new }

  describe '#player_input' do
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

  describe '#choose_markers' do
    context 'when the players select different markers' do
      before do
        allow(game).to receive(:gets).and_return("x\n", "o\n")
      end

      it 'sets each player\'s marker to the correct choice' do
        marker_a = 'x'
        marker_b = 'o'

        expect(game).to receive(:print).twice

        game.choose_markers

        game_marker_a = game.instance_variable_get(:@marker_a)
        game_marker_b = game.instance_variable_get(:@marker_b)

        expect(marker_a).to eq(game_marker_a)
        expect(marker_b).to eq(game_marker_b)
      end
    end

    context 'when a player chooses an already selected marker' do
      before do
        allow(game).to receive(:gets).and_return("x\n", "x\n", "x\n", "o\n")
      end

      it 'keeps asking it to change it until the player chooses another marker' do
        marker_a = 'x'
        marker_b = 'o'

        expect(game).to receive(:print).exactly(4).times
        expect(game).to receive(:puts).twice

        game.choose_markers

        game_marker_a = game.instance_variable_get(:@marker_a)
        game_marker_b = game.instance_variable_get(:@marker_b)

        expect(marker_a).to eq(game_marker_a)
        expect(marker_b).to eq(game_marker_b)
      end
    end
  end

  describe '#choose_turns' do
    context 'when a goes first' do
      let(:expected_players) { ['x', 'o'] }

      before do
        game.instance_variable_set(:@marker_a, expected_players[0])
        game.instance_variable_set(:@marker_b, expected_players[1])
        allow(game).to receive(:player_input).and_return('a')
      end

      it 'a\'s marker is at index 0 ' do
        game.choose_turns

        game_players = game.instance_variable_get(:@players)

        expect(game_players).to eq(expected_players)
      end
    end
  end

  context 'when b goes first' do
    let(:expected_players) { ['o', 'x'] }

    before do
      game.instance_variable_set(:@marker_a, expected_players[1])
      game.instance_variable_set(:@marker_b, expected_players[0])
      allow(game).to receive(:player_input).and_return('b')
    end

    it 'b\'s marker is first' do
      game.choose_turns

      game_players = game.instance_variable_get(:@players)

      expect(game_players).to eq(expected_players)
    end
  end

  describe '#player_select' do
    before do
      game.instance_variable_set(:@board, [
        'x', 'o', nil,
        nil, 'x', nil,
        nil, nil, 'o'
      ])
      game.instance_variable_set(:@players, ['x', 'o'])
      game.instance_variable_set(:@player_idx, 0)

      allow(game).to receive(:player_input).and_return('2')
    end

    context 'when the current player chooses a valid cell' do
      it 'allows it' do
        expected_board = [
          'x', 'o', 'x',
          nil, 'x', nil,
          nil, nil, 'o'
        ]
        game.player_select

        game_board = game.instance_variable_get(:@board)

        expect(game_board).to eq(expected_board)
      end
    end
  end

  describe '#full?' do
    context 'when the board is full' do
      before do
        game.instance_variable_set(:@board, [
          'x', 'o', 'x',
          'o', 'x', 'x',
          'o', 'x', 'o'
        ])
      end

      it 'returns true' do
        expect(game).to be_full
      end
    end

    context 'when the board is not full' do
      before do
        game.instance_variable_set(:@board, [
          'x', 'o', 'x',
          'o', nil, 'x',
          'o', 'x', 'o'
        ])
      end

      it 'returns false' do
        expect(game).not_to be_full
      end
    end
  end

  describe '#won?' do
    before do
      game.instance_variable_set(:@player_idx, 0)
      game.instance_variable_set(:@marker_a, 'x')
      game.instance_variable_set(:@marker_b, 'o')
    end

    context 'when there\'s a winner' do
      before do
        game.instance_variable_set(:@board, [
          'x', 'o', 'o',
          'x', 'o', 'o',
          'x', 'x', 'x'
        ])
      end

      it 'return true' do
        expect(game).to be_won
      end
    end

    context 'when there\'s no winner' do
      before do
        game.instance_variable_set(:@board, [
          'x', 'o', 'o',
          'x', 'o', 'o',
          nil, 'x', 'x'
        ])
      end

      it 'return false' do
        expect(game).not_to be_won
      end
    end
  end
end
