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
    valid_moves = moves.select do |move|
      move[0].between?(0,7) && move[1].between?(0,7)
    end
  end

  def pos=(val)
    @pos = val
  end

  def move_into_check?(end_pos)
  end



end