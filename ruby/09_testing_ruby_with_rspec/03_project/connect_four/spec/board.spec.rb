# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  let(:board) { described_class.new }

  describe '#to_s' do
    context 'when calling to_s' do
      before do
        columns = [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, 'x'],
          [nil, nil, nil, 'o', 'x', 'x'],
          %w[o x o x o o],
          [nil, nil, nil, 'x', 'o', 'o'],
          [nil, nil, nil, 'o', 'o', 'x'],
          [nil, nil, nil, 'x', 'x', 'o']
        ]

        board.instance_variable_set :@columns, columns
      end

      it 'it stringifies correctly' do
        expected = <<~HEREDOC
          1 2 3 4 5 6 7#{' '}
          _ _ _ o _ _ _#{' '}
          _ _ _ x _ _ _#{' '}
          _ _ _ o _ _ _#{' '}
          _ _ o x x o x#{' '}
          _ _ x o o o x#{' '}
          _ x x o o x o#{' '}
        HEREDOC

        expect(board.to_s).to eq expected
      end
    end
  end

  describe '#column_full?' do
    before do
      columns = [
        [nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, 'x'],
        [nil, nil, nil, 'o', 'x', 'x'],
        %w[o x o x o o],
        [nil, nil, nil, 'x', 'o', 'o'],
        [nil, nil, nil, 'o', 'o', 'x'],
        [nil, nil, nil, 'x', 'x', 'o']
      ]

      board.instance_variable_set :@columns, columns
    end

    context 'when a column is not full' do
      it "says it's not full" do
        expect(board.column_full?(5)).to be false
      end
    end

    context 'when column is full' do
      it "says it's full" do
        expect(board.column_full?(4)).to be true
      end
    end
  end

  describe '#full?' do
    context 'when the board is full' do
      before do
        columns = [
          %w[o o o x x x],
          %w[x x x o o o],
          %w[o o o x x x],
          %w[x x x o o o],
          %w[o o o x x x],
          %w[x x x o o o],
          %w[o x o x o x]
        ]

        board.instance_variable_set :@columns, columns
      end

      it "says that it's full" do
        expect(board).to be_full
      end
    end

    context 'when the board is not full' do
      before do
        columns = [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, 'x'],
          [nil, nil, nil, 'o', 'x', 'x'],
          %w[o x o x o o],
          [nil, nil, nil, 'x', 'o', 'o'],
          [nil, nil, nil, 'o', 'o', 'x'],
          [nil, nil, nil, 'x', 'x', 'o']
        ]

        board.instance_variable_set :@columns, columns
      end

      it "says that it's not full" do
        expect(board).to_not be_full
      end
    end
  end

  describe '#winner' do
    context "when there's no winner" do
      before do
        columns = [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, 'x'],
          [nil, nil, nil, 'o', 'x', 'x'],
          %w[o x o x o o],
          [nil, nil, nil, 'x', 'o', 'o'],
          [nil, nil, nil, 'o', 'o', 'x'],
          [nil, nil, nil, 'x', 'x', 'o']
        ]

        board.instance_variable_set :@columns, columns
      end

      it 'returns `nil`' do
        expect(board.winner).to be_nil
      end
    end

    context "when there's a winner" do
      before do
        columns = [
          [nil, 'o', 'o', 'o', 'o', 'x'],
          [nil, nil, 'x', 'x', 'x', 'o'],
          [nil, nil, nil, nil, nil, 'x'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]

        board.instance_variable_set :@columns, columns
      end

      it 'finds it' do
        expect(board.winner).to be 'o'
      end
    end
  end

  describe '#update' do
    context 'when updating' do
      before do
        columns = [
          [nil, 'o', 'o', 'o', 'o', 'x'],
          [nil, nil, 'x', 'x', 'x', 'o'],
          [nil, nil, nil, nil, nil, 'x'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]

        board.instance_variable_set :@columns, columns
      end

      it 'updates' do
        column = 1
        piece = 'x'
        expect { board.update(column, piece) }.to change { board.column_full?(column) }.from(false).to(true)
      end
    end
  end
end
