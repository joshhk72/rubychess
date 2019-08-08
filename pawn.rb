require_relative 'piece'

class Pawn < Piece

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :P
    @at_start_row = false
  end

  def moves #add later
    forward_steps + side_attacks
  end

  def forward_steps
  end

  def side_attacks
    x, y = pos
    new_pos = [(x + forward_dir), 0]
    if !board[new_pos].is_a?(NullPiece)
      board[new_pos] =
    end
  end

  def forward_dir
    if color == black
      1
    else
      -1
    end
  end

  def move_dirs
    fd = forward_dir
    [[fd, 0], [fd, 1], [fd, -1]
  end

  private

  attr_reader :at_start_row

end