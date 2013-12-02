# encoding: utf-8
require_relative 'steppingpieces'

class King < SteppingPieces
  def move_dir
    STRAIGHTS + DIAGONALS
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♚" : "♔"
  end
end
