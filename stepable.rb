module Stepable

  def moves
    potential_moves = move_diffs.map! { |diff| [diff[0] + pos[0], diff[1] + pos[1]] }
    potential_moves.select! { |move| move[0].between?(0,7) && move[1].between?(0,7) }
      .reject { |new_pos| board[new_pos].color == color }
  end

  def move_diffs
    [[1, 0],[-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

end