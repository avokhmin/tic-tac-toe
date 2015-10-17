require 'matrix'

class Game
  include ActiveModel::Serialization
  include ActiveModel::Conversion
  include ActiveModel::Validations

  GAME_EXPIRATION = 1.hour

  attr_reader :id
  attr_accessor :size, :board, :users

  validates :size,
            presence:     true,
            numericality: { greater_than_or_equal_to: 3 }

  validates :board,
            presence:     true

  validates :users,
            presence:     true

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
  # Returns the User key if tic is successful, false otherwise.
  def tic(row: nil, column: nil)
    return false unless board[row][column].zero?
    board[row][column] = current_user.key
  end

  # Public: Next move.
  #
  # Returns the Array of User instances.
  def next_move
    users.rotate!
  end

  # Public: Check if game is persisted.
  #
  # Returns true if it is, false otherwise.
  def persisted?
    id.present?
  end

  # Public: Save a game to cache.
  #
  # Returns true if it is, false otherwise.
  def save
    return unless valid?
    @id = SecureRandom.uuid unless persisted?
    Rails.cache.write ['Game#find', @id], self, expires_in: GAME_EXPIRATION
  end

  # Public: Destroy a game from cache.
  #
  # Returns true if it is, false otherwise.
  def destroy
    Rails.cache.delete ['Game#find', @id]
  end

  # Public: Get current user.
  #
  # Returns current User instance.
  def current_user
    users.first
  end

  # Public: Get cached Game by ID.
  #
  # id - the String ID.
  #
  # Returns Game instance or nil if it's not found.
  def self.find(id)
    Rails.cache.read ['Game#find', id]
  end

  # Public: Add a new winner to the TOP list.
  #
  # user - the User instance.
  def self.add_winner(user)
    users = winners || []
    users.unshift user
    Rails.cache.write 'Game#winners', users.first(10)
  end

  # Public: Get all winners
  #
  # Returns the Array of users.
  def self.winners
    Rails.cache.read('Game#winners') || []
  end

end
