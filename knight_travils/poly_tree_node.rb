class PolyTreeNode
    
    attr_accessor :children, :parent, :value, 
    def inspect
        {'value' => @value, 'parent_value' => @parent.value }.inspect
    end

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(new_parent)
        if self.parent != nil
            self.parent.children.each_with_index do |el, i|
                self.parent.children.delete_at(i) if self.object_id == el.object_id
            end
        end

        new_parent.children << self if new_parent != nil
        @parent = new_parent
    end

    def add_child(child_node)
        child_node.parent = self 
    end
    
    def remove_child(child_node)
        if !self.children.include?(child_node)
            raise "not a child"
        end
        child_node.parent = nil
    end

    def dfs(target_value)
        p self.value
        if self.value == target_value
            return self 
        end
        self.children.each do |c| 
            recursed_value = c.dfs(target_value)
            return recursed_value if recursed_value != nil
        end
        return nil
    end


    def bfs(target_value)
        return self if self.value == target_value
        queue = []
        self.children.each {|c| queue << c}
        while !queue.empty?
            current = queue.shift
            #p current.value
            return current if current.value == target_value
            current.children.each {|c| queue << c}
        end
        return nil
    end
end
