class GameSerializer < ActiveModel::Serializer
  attributes :id
  attributes :board
  attributes :users
  attributes :size

  private

  # Private: Get game board.
  #
  # Returns the Array of Array.
  def board
    object.board.map.with_index do |row, row_id|
      row.map.with_index do |column, column_id|
        { value: column, row: row_id, column: column_id }
      end
    end
  end

end
