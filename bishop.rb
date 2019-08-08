require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include Slideable

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :B
  end

  def move_dirs
    :diagonal
  end
end