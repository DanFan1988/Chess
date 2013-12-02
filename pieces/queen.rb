# encoding: utf-8
require_relative 'slidingpieces'

class Queen < SlidingPieces
  def move_dirs
    STRAIGHTS + DIAGONALS
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♛" : "♕"
  end
end
