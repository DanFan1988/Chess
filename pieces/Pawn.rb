# encoding: utf-8
require_relative 'piece'

class Pawn < Piece
  attr_accessor :unicode_char, :position

  STRAIGHTS = [   [ 1,  0],
                  [ 2,  0]]

  DIAGONALS = [     [ 1,  1],
                    [ 1, -1]]

  INVERTED_STRAIGHTS = [   [ -1, 0],
                           [ -2, 0]]

  INVERTED_DIAGONALS = [[ -1,  -1],
                        [ -1,   1]]

  def initialize(grid, position, color)
    super(grid, position, color)
    @straights = STRAIGHTS
    @diagonals = DIAGONALS
    @unicode_char
    direction_setter
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♟" : "♙"
  end

  def moves
    possible_moves = []

    x = @position[0]
    y = @position[1]

    unless blocked?(x, y)
      possible_moves << [x + @straights[0][0], y]
      if jump?(x,y)
        possible_moves << [x +@straights[1][0], y]
      end
    end
    possible_moves.concat(eat_diagonals(x,y))
  end

  def direction_setter
    if @color == "white"
      @straights = INVERTED_STRAIGHTS
      @diagonals = INVERTED_DIAGONALS
    end
  end

  def blocked?(x, y)
    forward_one = @straights[0]
    !@grid.grid[x + forward_one[0]][y].nil?
  end

  def jump?(x,y)
    forward_two = @straights[1]
    @grid.grid[x + forward_two[0]][y].nil?
  end

  def eat_diagonals(x,y)
    diagonal_moves = []
    @diagonals.each do |diagonal|
      next if @grid.grid[x+diagonal[0]][y+diagonal[1]].nil?
      unless @grid.grid[x+diagonal[0]][y+diagonal[1]].color == @color
        diagonal_moves << [x+diagonal[0],y+diagonal[1]]
      end
    end
    diagonal_moves
  end
end

