require_relative 'board'
require_relative 'player'
require_relative 'display'

class ColorError < ArgumentError
end

class Game
  attr_accessor :current_player
  attr_reader :player_1, :player_2, :display, :board

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player_1 = HumanPlayer.new(:white, @display)
    @player_2 = HumanPlayer.new(:black, @display)
    @current_player = @player_1
  end

  def turn_swap
    self.current_player = current_player == player_1 ? player_2 : player_1
  end

  def other_player
    current_player == player_1 ? player_2 : player_1
  end

  def play_turn
    until board.selected_from && board.selected_to
      system "clear"
      puts "#{@current_player.color.capitalize}'s turn."
      display.render
    end
    if board[board.selected_from].color == other_player.color 
      raise ColorError.new("You must select pieces of your own color!")
    end
    board.move_piece(board.selected_from, board.selected_to)
  rescue InvalidMoveError, NoPieceError, CheckError, ColorError => e
    board.reset_selection
    puts e.message
    puts "Press enter to continue"
    inputs = gets.chomp
    retry
  end

  def play_game
    until board.checkmate?(:black) || board.checkmate?(:white)
      play_turn
      board.reset_selection
      turn_swap
    end
    system "clear"
    puts "#{other_player.color.capitalize}'s victory!"
    display.render
  end

end

game = Game.new
game.play_game