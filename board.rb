# encoding: utf-8
require_relative 'pieces/pawn'
require_relative 'pieces'
require_relative 'exceptions'
require 'colorize'

class Board

  attr_accessor :grid

  def initialize(grid = nil)
    if grid.nil?
      @grid = Array.new(8) {Array.new(8)}
      set_up_pawns
      set_up_others
    else
      @grid = grid
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)

    pieces.select { |piece| piece.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def pieces
    @grid.flatten.compact
  end

  def within_bounds?(x, y)
    [x, y].min >= 0 && [x, y].max < 8
  end

  def display_grid
    puts "   0 1 2 3 4 5 6 7"
    puts
    @grid.each_with_index do |row, index|
      print "#{index}  "
      row.each_with_index do |tile, idx|
        bg_color = (idx.odd? && index.odd?) || (idx.even? && index.even?) ? :red : :white
        if tile.nil?
          print "  ".colorize(:color => :black, :background => bg_color)
        else
          print "#{tile.render_unicode} ".colorize(:color => :black, :background => bg_color)
        end
      end
      puts
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def move(start_pos, end_pos)
    unless self[start_pos].valid_moves.include?(end_pos)
      raise MovePieceError.new("Invalid ending position")
    end

    move!(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)
    a, b = start_pos
    x, y = end_pos

    @grid[x][y] = @grid[a][b]
    @grid[a][b] = nil
    @grid[x][y].position = end_pos
  end

  def in_check?(color)
    king_position = find_king_pos(color)
    return true if possible_opposing_moves(color).include?(king_position)
  end

  def dup
    duped_board = Board.new

    pieces.each do |piece|
      piece.class.new(duped_board, piece.position, piece.color)
    end
    duped_board
  end

  private

  def find_king_pos(color)
    pieces.each do |piece|
        return piece.position if (piece.is_a?(King) && piece.color == color)
    end
  end

  def possible_opposing_moves(color)
    opposing_pieces = pieces.select do |piece|
      piece.color != color
    end
    possible_moves = opposing_pieces.inject([]) do |result, piece|
      result.concat(piece.moves)
    end
    possible_moves.uniq
  end

  def set_up_pawns
    [1, 6].each do |row|
      color = row == 1 ? "black" : "white"
      @grid[row].each_index do |col|
        @grid[row][col] = Pawn.new(self, [row, col], color)
      end
    end
  end

  BACKROW_PIECES =
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def set_up_others
    [0, 7].each do |row|
      color = row == 0 ? "black" : "white"
      BACKROW_PIECES.each_with_index do |piece, col|
        @grid[row][col] = piece.new(self, [row, col], color)
      end
    end
  end
end
