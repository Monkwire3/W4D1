require 'byebug'
require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @prev_move_pos = prev_move_pos
    @next_mover_mark = next_mover_mark
  end

  # def print_board(board)
  #   board.each do |row|
  #     p row
  #   end
  # end
  
  def losing_node?(evaluator)
    if self.board.over?
      return false if self.board.winner == nil
    end
    return self.board.winner != evaluator && self.board.winner != nil if self.board.over? 
    #return false if self.board.winner == nil if self.children.length == 0

    
    if self.next_mover_mark == evaluator
      return self.children.all? {|child| child.losing_node?(evaluator)}
    else
      return self.children.any? {|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    return self.board.winner == evaluator if self.board.over?

    if self.next_mover_mark == evaluator
      return self.children.any? {|child| child.winning_node?(evaluator)}
    else
      return self.children.all? {|child| child.winning_node?(evaluator)}
    end
    
  end

  def swap_mark
    return next_mover_mark == :x ? :o : :x
  end
  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    @board.rows.length.times do |i_1|
      @board.rows.length.times do |i_2|
        if @board.empty?([i_1, i_2])
          #debugger
          child = TicTacToeNode.new(@board.dup, swap_mark, [i_1, i_2])
          child.board[[i_1, i_2]] = swap_mark
          children << child
        end
      end
    end
  return children
  end


end


