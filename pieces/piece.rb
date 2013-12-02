class Piece
  attr_accessor :unicode_char, :position
  STRAIGHTS = [
    [ 0,  1],
    [ 1,  0],
    [-1,  0],
    [ 0, -1]
  ]

  DIAGONALS = [
    [ 1,  1],
    [ 1, -1],
    [-1, -1],
    [-1,  1]
  ]

  attr_reader :color

  def initialize(grid, position, color)
    @grid, @position, @color = grid, position, color
    @unicode_char
  end

  def moves
    raise NotImplimented
  end

  def valid_moves
    valids = []
    moves.each do |possible_move|
      duped_board = @grid.dup
      duped_board.move!(@position, possible_move)
      valids << possible_move unless duped_board.in_check?(@color)
    end
    valids
  end
end

