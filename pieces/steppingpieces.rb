require_relative 'piece'

class SteppingPieces < Piece
  def moves
    possible_moves = []

    move_dir.each do |move_dir|
      y = @position[1] + move_dir[1]
      x = @position[0] + move_dir[0]

      next unless @grid.within_bounds?(x, y)

      if @grid.grid[x][y].nil?
        possible_moves << [x, y]
      elsif @grid.grid[x][y].color != @color
        possible_moves << [x, y]
      end
    end
    possible_moves
  end
end