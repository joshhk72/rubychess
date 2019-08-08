require_relative 'board'
require_relative 'player'
require_relative 'display'

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = Player.new(:black, @display)
    @player2 = Player.new(:white, @display)
  end

  def play
    until board.checkmate?(:black) || board.checkmate?(:white)
      turn_swap
    end

  end


end