class Piece
  attr_accessor :unicode_char
  STRAIGHTS = [   [ 0,  1],
                  [ 1,  0],
                  [-1,  0],
                  [ 0, -1]]

  DIAGONALS = [     [ 1,  1],
                    [ 1, -1],
                    [-1, -1],
                    [-1,  1]]

  attr_reader :position, :color

  def initialize(grid, postion, color)
    @grid = grid
    @position = position
    @color = color
    @unicode_char
  end

  def moves
    raise NotImplimented
  end

  def valid_move?


  end

end

