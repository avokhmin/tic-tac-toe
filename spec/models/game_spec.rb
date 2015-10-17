require 'rails_helper'

RSpec.describe Game, type: :model do

  it { is_expected.to validate_presence_of(:size) }
  it { is_expected.to validate_numericality_of(:size).is_greater_than_or_equal_to(3) }

  it { is_expected.to validate_presence_of(:users) }
  it { is_expected.to validate_presence_of(:board) }

  let(:user1) { User.new(name: 'Foo', key: 1) }
  let(:user2) { User.new(name: 'Bar', key: 2) }
  let(:users) { [user1, user2] }
  let(:game)  { Game.new(users: users) }

  describe '#initialize' do
    let(:game)  { Game.new(size: 4, users: users) }

    it 'initializes a board' do
      expect(game.board).to eq Matrix.zero(4).to_a
    end

    it 'assigns an users' do
      expect(game.users).to eq [user1, user2]
    end

    it 'assigns a size' do
      expect(game.size).to eq 4
    end
  end

  describe '#win?' do
    it 'returns false for new game' do
      expect(game.win?).to be_falsy
    end

    it 'returns true if won by horizontally' do
      allow(game).to receive(:board) {
        [
          [0,1,1],
          [1,1,1],
          [0,2,2]
        ]
      }

      expect(game.win?).to be_truthy
    end

    it 'returns true if won by vertically' do
      allow(game).to receive(:board) {
        [
          [0,1,0],
          [1,1,2],
          [1,1,2]
        ]
      }

      expect(game.win?).to be_truthy
    end

    it 'returns true if won by diagonally "\"' do
      allow(game).to receive(:board) {
        [
          [1,1,0],
          [2,1,2],
          [1,2,1]
        ]
      }

      expect(game.win?).to be_truthy
    end

    it 'returns true if won by diagonally "/"' do
      allow(game).to receive(:board) {
        [
          [0,1,1],
          [2,1,2],
          [1,2,1]
        ]
      }

      expect(game.win?).to be_truthy
    end

    it 'returns false if drawn' do
      allow(game).to receive(:board) {
        [
          [1,1,2],
          [2,2,1],
          [1,2,2]
        ]
      }

      expect(game.win?).to be_falsy
    end
  end

  describe '#drawn?' do
    it 'returns false for new game' do
      expect(game.drawn?).to be_falsy
    end

    it 'returns true if drawn' do
      allow(game).to receive(:board) {
        [
          [1,1,2],
          [2,2,1],
          [1,2,2]
        ]
      }

      expect(game.drawn?).to be_truthy
    end
  end

  describe '#tic' do
    it 'returns true if updates a board' do
      expect(game.tic(row: 1, column: 2)).to be_truthy
      expect(game.board).to eq [
        [0, 0, 0],
        [0, 0, 1],
        [0, 0, 0]
      ]
    end

    it 'returns false if can not update a board' do
      expect(game.tic(row: 1, column: 2)).to be_truthy
      expect(game.tic(row: 1, column: 2)).to be_falsy
    end
  end

  describe '#next_move' do
    it 'rotates an users' do
      game.next_move
      expect(game.users).to eq [user2, user1]
    end
  end

end
