require 'singleton'
require_relative 'piece'

class NullPiece < Piece
  include Singleton

  attr_reader :symbol, :color, :pos

  def initialize
    @pos = nil
    @symbol = :Np
    @color = :grey
    @board = board
  end

  def moves
    []
  end

  def pos=(val)
    nil
  end
end