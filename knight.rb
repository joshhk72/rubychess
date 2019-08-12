require_relative 'stepable'
require_relative 'piece'

class Knight < Piece
  include Stepable

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :N
  end

  def move_diffs
    [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end
end