# encoding: utf-8
require_relative 'slidingpieces'

class Rook < SlidingPieces
  def move_dirs
    STRAIGHTS
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♜" : "♖"
  end
end