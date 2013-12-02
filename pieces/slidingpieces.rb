require_relative 'piece'

class SlidingPieces < Piece

  def moves
    possible_moves = []

    move_dirs.each do |move_dir|
      possible_moves.concat(single_direction_moves(move_dir))
    end
    possible_moves
  end

  def single_direction_moves(move_dir)
    one_direction_moves = []
    y = @position[1] + move_dir[1]
    x = @position[0] + move_dir[0]

   while @grid.within_bounds?(x, y)

      if @grid.grid[x][y].nil?
        one_direction_moves << [x, y]
      elsif @grid.grid[x][y].color  == @color
        break
      elsif @grid.grid[x][y].color != @color
        one_direction_moves << [x, y]
        x = -9 #setting piece out of bound to break loop
      end
      y += move_dir[1]
      x += move_dir[0]
    end

    one_direction_moves
  end
end