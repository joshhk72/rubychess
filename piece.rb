class Piece
  
  attr_accessor :pos, :board
  attr_reader :symbol, :color

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @symbol = :Pi
  end

  def to_s
    symbol.to_s
  end

  def empty?
    return self.is_a?(NullPiece)
  end

  def valid_moves # phase 3 stuff
    moves.reject do |future_pos|
      new_board = board.deep_dup
      new_board.move_piece(pos, future_pos)
      new_board.in_check?(color)
    end
  end

  def pos=(val)
    @pos = val
  end

  def move_into_check?(end_pos)
    duped = board.dup
  end



end