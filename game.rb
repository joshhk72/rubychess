require_relative 'board'
require_relative 'player'
require_relative 'display'

class Game
  attr_accessor :current_player
  attr_reader :player_1, :player_2, :display, :board

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player_1 = HumanPlayer.new(:black, @display)
    @player_1 = HumanPlayer.new(:white, @display)
    @current_player = @player_1
  end

  def turn_swap
    self.current_player = current_player == player_1 ? player_2 : player_1
  end

  def play
    until board.checkmate?(:black) || board.checkmate?(:white)
      begin
        until board.selected_from && board.selected_to
          system "clear"
          puts "#{@current_player}'s turn."
          display.render
        end
        board.move_piece(board.selected_from, board.selected_to)
      rescue => e #InvalidMoveError, NoPieceError, CheckError => e
        board.reset_selection
        puts e.message
        puts "Press enter to continue"
        inputs = gets.chomp
        retry
      end
      board.reset_selection
      turn_swap
    end

  end
end

game = Game.new
game.play