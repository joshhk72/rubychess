require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include Slideable

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :Q
  end

  def move_dirs
    :both
    
  end

end