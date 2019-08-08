module Stepable

  def moves

    potential_moves = move_diffs
      .map { |diff| diff + pos }
      .reject { |new_pos| board[new_pos].color == color }
  end

  def move_diffs
    [[1, 0],[-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

end