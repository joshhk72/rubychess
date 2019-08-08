require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
  include Slideable

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :R
  end

  def move_dirs
    :straight
  end

end