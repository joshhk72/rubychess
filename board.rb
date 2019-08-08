#https://assets.aaonline.io/fullstack/ruby/assets/Chess_Diagram.png

require_relative 'piece'
require_relative 'rook'
require_relative 'queen'
require_relative 'bishop'
require_relative 'nullpiece'
require_relative 'pawn'
require_relative 'knight'
require_relative 'king'

class Board

  class NoPieceError < StandardError
  end

  class InvalidMoveError < ArgumentError
  end

  def initialize
    @grid = Array.new(8) { Array.new(8, NullPiece.instance) } #change nil to nullpiece
    setup_board
  end

  def setup_board
    piece_order = ['Rook', 'Knight', 'Bishop', 'King', 'Queen', 'Bishop', 'Knight', 'Rook']
    piece_order.each_with_index do |piece_name, idx|
      class_name = Object.const_get(piece_name)
      grid[0][idx] = class_name.new(:black, [0, idx], self)
    end
    grid[1].map!.with_index { |piece, idx| Pawn.new(:black, [1, idx], self) }
    grid[6].map!.with_index { |piece, idx| Pawn.new(:white, [6, idx], self) }
    piece_order.each_with_index do |piece_name2, idx2|
      class_name = Object.const_get(piece_name2)
      grid[7][idx2] = class_name.new(:white, [7, idx2], self)
    end
  end
  
  def valid_pos?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def checkmate?(color)
  end

  def move_piece(start_pos, end_pos)
    raise NoPieceError.new("There is no piece at this chosen position") if self[start_pos].is_a?(NullPiece)
    raise InvalidMoveError.new("The selected piece can not move to this position") if !self[start_pos].valid_moves.include?(end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos].pos = end_pos
  end

  def [](position)
    grid[position[0]][position[1]]
  end

  def []=(position, piece)
    grid[position[0]][position[1]] = piece
  end

  def inspect
    grid.map do |row|
      row.map do |piece|
        piece.symbol
      end
    end
  end

  private

  attr_reader :grid

end