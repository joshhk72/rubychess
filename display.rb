require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display

  def initialize(board)
    @board = board
    @size = 7
    @cursor = Cursor.new([0,0], board)
  end

  def color_cursor(pos)
    current_cursor = cursor.cursor_pos
    if current_cursor == pos && cursor.selected
      return :blue
    end
    :red
  end

  def get_input
    cursor.get_input
  end

  def render
    curs = cursor.cursor_pos
    top_string = "  a b c d e f g h  "
    puts top_string
    (0..7).each do |idx1|
      row_str = "" 
      row_str += (8-idx1).to_s
      (0..7).each do |idx2|
        row_str += " "
        pos = [idx1, idx2]
        sym_str = board[pos].symbol.to_s
        sym_str = sym_str.colorize(color_cursor(pos)) if curs == pos
        row_str += sym_str
      end
      puts row_str
    end
    p board.selected_from
    p board.selected_to
    cursor.get_input
  end

  # 8 board[[0,0-7]]

  private

  attr_reader :board, :cursor
end