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
  attr_accessor :selected_from, :selected_to

  class NoPieceError < StandardError
  end

  class InvalidMoveError < ArgumentError
  end

  class CheckError < ArgumentError
  end

  def initialize
    @grid = Array.new(8) { Array.new(8, NullPiece.instance) } #change nil to nullpiece
    setup_board
    @selected_from = nil
    @selected_to = nil
  end

  def setup_board
    piece_order = ['Rook', 'Knight', 'Bishop', 'Queen', 'King', 'Bishop', 'Knight', 'Rook']
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

  def reset_selection
    @selected_from = nil
    @selected_to = nil
    nil
  end
  
  def valid_pos?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def find_king(color)
    grid.each_with_index do |row, idx1|
      row.each_with_index do |square, idx2|
        return [idx1, idx2] if self[[idx1, idx2]].class == King && self[[idx1,idx2]].color == color
      end
    end
    nil
  end

  def in_check?(color)
    pieces.each do |piece|
      return true if piece.moves.include?(find_king(color))
    end
    false
  end

  def checkmate?(color)
    return false if !in_check?(color)

    player_pieces = pieces.select { |piece| piece.color == color }
    player_pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def pieces
    grid.flatten.reject { |piece| piece.is_a?(NullPiece) }
  end

  def move_piece(start_pos, end_pos)
    raise NoPieceError.new("There is no piece at this chosen position") if self[start_pos].is_a?(NullPiece)
    raise InvalidMoveError.new("The selected piece can not move to this position.") unless self[start_pos].moves.include?(end_pos)
    raise CheckError.new("That move will leave you in check!") unless self[start_pos].valid_moves.include?(end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos].pos = end_pos
    self[end_pos].at_start_row = false if self[end_pos].class == Pawn
  end

    def move_piece!(start_pos, end_pos)
    raise NoPieceError.new("There is no piece at this chosen position") if self[start_pos].is_a?(NullPiece)
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

  def deep_dup
    duped = Board.new # copies board
    #duped.grid = grid.dup # updates reference to @grid for new board
    grid.each_with_index do |row, idx1| # dupes pieces
      row.each_with_index do |piece, idx2|
        if piece.is_a?(NullPiece)
          duped[[idx1, idx2]] = NullPiece.instance
        else
          new_piece = piece.class.new(piece.color, piece.pos.dup, duped)
          duped[[idx1, idx2]] = new_piece
        end
      end
    end
    duped
  end

  protected

  attr_accessor :grid

end