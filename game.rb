require './board'
require './exceptions'

class Game
  def initialize
    @board = Board.new
  end

  def play(player1, player2)
    current_player = player1

    until @board.checkmate?(current_player.color)
      puts "#{current_player.color.capitalize}'s Turn \n\n"

      begin
        @board.display_grid
        start_pos, end_pos = current_player.play_turn
        check_move_validity(start_pos, current_player)
        @board.move(start_pos, end_pos)
      rescue NotYourPieceError => error
        puts error.message
        retry
      rescue MovePieceError => error
        puts error.message
        retry
      end

      current_player = current_player == player1 ? player2 : player1
    end
    puts "#{current_player.color.capitalize} won!"
  end

  def check_move_validity(start_pos, current_player)
    if @board[start_pos].nil?
      raise MovePieceError.new("No piece at starting position")
    elsif @board[start_pos].color != current_player.color
      raise NotYourPieceError.new("You can't move the other player's piece.")
    end
  end
end

class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
    puts "Please choose a starting piece to move, enter in this format 'x,y'"
    start_pos = gets.chomp.split(",").map { |i| i.to_i }

    puts "Where would you like to move the piece, enter in this format 'x,y'"
    end_pos = gets.chomp.split(",").map { |i| i.to_i }

    [start_pos, end_pos]
  end

end

if $PROGRAM_NAME == __FILE__
  new_game = Game.new

  player1 = HumanPlayer.new("white")
  player2 = HumanPlayer.new("black")
  new_game.play(player1, player2)

end