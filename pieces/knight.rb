# encoding: utf-8
require_relative 'steppingpieces'

class Knight < SteppingPieces

  def move_dir
    [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]
    ]
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♞" : "♘"
  end
end