require 'matrix'

class Game

  attr_reader :size, :board, :users

  # Public: Constructor.
  #
  # size  - the Integer board size (default: 3).
  # users - the Array of User instances.
  def initialize(size: 3, users: [])
    @size         = size
    @board        = Matrix.zero(size).to_a
    @users        = users
  end

  # Public: Check if current user is won.
  #
  # Returns true if it is, false otherwise.
  def win?
    matrix = Matrix[*board]
    pvec   = Matrix.build(1, size) { current_user.key }.row(0)
    matrix.row_vectors.any? { |r| r == pvec }      ||                   # Horizontal
      matrix.column_vectors.any? { |c| c == pvec } ||                   # Vertical
      Vector[*matrix.each(:diagonal).to_a] == pvec ||                   # Diagonal "\"
      @size.times.all? { |i| board[i][size-i-1] == current_user.key } # Diagonal "/"
  end

  # Public: Check if game is drawn.
  #
  # Returns true if it is, false otherwise.
  def drawn?
    !Matrix[*board].include?(0)
  end

  # Public: Perform new tic.
  #
  # row    - the Integer row.
  # column - the Integer column.
  #
  # Returns true if tic is successful, false otherwise.
  def tic(row: nil, column: nil)
    return false unless board[row][column].zero?
    board[row][column] = current_user.key
    true
  end

  # Public: Next move.
  #
  # Returns the Array of User instances.
  def next_move
    users.rotate!
  end

  private

  # Private: Get current user.
  #
  # Returns current User instance.
  def current_user
    users.first
  end

end
