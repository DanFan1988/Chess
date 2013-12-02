# encoding: utf-8
require_relative 'slidingpieces'

class Bishop < SlidingPieces
  def move_dirs
    DIAGONALS
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♝" : "♗"
  end
end