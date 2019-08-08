module Slideable
  
  def moves
    possible_moves = []

    if move_dirs == :diagonal || move_dirs == :both
      diagonal_dirs.each do |dir|
        x, y = dir
        possible_moves += grow_unblocked_moves_in_dir(x, y)
      end
    end

    if move_dirs == :straight || move_dirs == :both
      straight_dirs.each do |dir|
        x, y = dir
        possible_moves += grow_unblocked_moves_in_dir(x, y)
      end
    end
    possible_moves
  end

  def move_dirs
    :both
  end

  def straight_dirs
    STRAIGHT
  end

  def diagonal_dirs
    DIAGONAL
  end

  private

  def grow_unblocked_moves_in_dir(dx, dy)
    unblocked_moves = []

    row, col = pos
    
    col += dx 
    row -= dy 
    
    until !board[[row, col]].is_a?(NullPiece)
      unblocked_moves << [row, col]
      col += dx
      row -= dy
    end
    unblocked_moves << [row, col] unless color == board[[row,col]].color

    unblocked_moves
  end

  STRAIGHT = [[1, 0],[-1, 0], [0, 1], [0, -1]]
  DIAGONAL = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
end