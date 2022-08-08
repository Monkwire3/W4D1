require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)

    possible_moves = node.children
    #debugger

    possible_moves.each do |move|
      return move.prev_move_pos if move.winning_node?(mark)
    end

    node.children.each do |move|
      return move.prev_move_pos if !move.losing_node?(mark)
    end

    raise StandardError "Only losing nodes"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
