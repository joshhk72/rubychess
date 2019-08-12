module Stepable

  def moves
    potential = move_diffs.map { |diff| [diff[0] + pos[0], diff[1] + pos[1]] }
    selected = potential.select { |new_p| board.valid_pos?(new_p) && board[new_p].color != color  }
  end

  def move_diffs
    [[1, 0],[-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

end