require_relative 'piece'

class Pawn < Piece

  attr_accessor :at_start_row

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :P
    @at_start_row = true
  end

  def moves
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
    possible_moves.select! { |side_position| board.valid_pos?(side_position) }
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
end