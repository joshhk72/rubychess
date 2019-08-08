require_relative 'piece'

class Pawn < Piece

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :P
    @at_start_row = true
  end

  def moves #add later
    forward_steps + side_attacks
  end

  def forward_steps
    possible_moves = [[pos[0] + forward_dir, pos[1]]]
    possible_moves << [pos[0] + forward_dir * 2, pos[1]] if at_start_row
    possible_moves.reject! do |move|
      !board[move].is_a?(NullPiece)
    end
    possible_moves
  end

  def side_attacks
    possible_moves = [[pos[0] + forward_dir, pos[1] + 1], [pos[0] + forward_dir, pos[1] - 1]]
    possible_moves.select do |side_position|
      board[side_position].color != color && !board[side_position].is_a?(NullPiece)
    end
  end

  def forward_dir
    if color == :black
      1
    else
      -1
    end
  end

  # def move_dirs
  #   fd = forward_dir
  #   [[fd, 0], [fd, 1], [fd, -1]]
  # end

  private

  attr_reader :at_start_row

end