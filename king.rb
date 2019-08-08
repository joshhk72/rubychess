require_relative "stepable"
require_relative "piece"

class King < Piece
  include Stepable

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :K


  end
end