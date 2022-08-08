require_relative 'poly_tree_node'

class KnightPathFinder

    attr_reader :considered, :root_node

    

    def self.is_valid?(pos)
        return !(pos[0] < 0 || pos[0] > 7 || pos[1] < 0 || pos[1] > 7)
    end

    def self.get_valid_moves(pos)
        valid_moves = []

        valid_moves << [pos[0] + 2, pos[1] - 1] if self.is_valid?([pos[0] + 2, pos[1] - 1])
        valid_moves << [pos[0] + 2, pos[1] + 1] if self.is_valid?([pos[0] + 2, pos[1] + 1])
        valid_moves << [pos[0] - 2, pos[1] - 1] if self.is_valid?([pos[0] - 2, pos[1] - 1])
        valid_moves << [pos[0] - 2, pos[1] + 1] if self.is_valid?([pos[0] - 2, pos[1] + 1])
        valid_moves << [pos[0] + 1, pos[1] - 2] if self.is_valid?([pos[0] + 1, pos[1] - 2])
        valid_moves << [pos[0] - 1, pos[1] - 2] if self.is_valid?([pos[0] - 1, pos[1] - 2])
        valid_moves << [pos[0] + 1, pos[1] + 2] if self.is_valid?([pos[0] + 1, pos[1] + 2])
        valid_moves << [pos[0] - 1, pos[1] + 2] if self.is_valid?([pos[0] - 1, pos[1] + 2])
    end

    def initialize(pos)
        @pos = pos
        @considered = []
        @root_node = PolyTreeNode.new(pos)
    end
    require 'byebug'
    def build_move_tree
        #debugger
        queue = []
        queue += build_children(@root_node)
        while !queue.empty?
            queue += build_children(queue.shift)
        end
    end

    def build_children(node)
        moves = KnightPathFinder.get_valid_moves(node.value)
        unconsidered_moves = []
        return [] if moves == nil 
        moves.each do |m|
            unconsidered_moves << m if !@considered.include?(m)
        end
        unconsidered_moves.each do |m|
            node.add_child(PolyTreeNode.new(m))
            @considered << m
        end
        return node.children
    end



end


k = KnightPathFinder.new([3,3])
k.build_move_tree
p k.root_node
p k.considered.length

#p KnightPathFinder.get_valid_moves([3,3])