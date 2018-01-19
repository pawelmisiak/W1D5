require "byebug"
class KnightPathFinder
  
  def initialize(position)
    @parent_pos = Node.new(position)
    @visited_positions = []
    #@visited_positions << @parent_pos
    @visited_positions << position
    build_move_tree
  end
  
  def self.valid_moves(pos)
    x, y = pos
    moves = [[x-1, y+2],
             [x+1, y+2],
             [x+2, y+1],
             [x+2, y-1],
             [x+1, y-2],
             [x-1, y-2],
             [x-2, y-1],
             [x-2, y+1]]
    valid = moves.select { |el| el.first.between?(0,7) && el.last.between?(0,7) }
    valid.map { |el| Node.new(el) }
  end
  
  def build_move_tree
    queue = [@parent_pos]
    until queue.empty?
      parent = queue.shift
      debugger
      children = new_move_positions(parent.value)
      children.each do |el| 
        parent.add_child(el)
        queue << el 
      end
    end
  end
  
  
  
  # def no_possible
  #   return false if new_move_positions(position)
  # end
  
  def new_move_positions(pos)
    debugger
    possible = self.class.valid_moves(pos).reject { |move| @visited_positions.include?(move.value) }
    @visited_positions += possible
    possible
  end
  
end

class Node
  attr_reader :parent
  attr_accessor :children, :value
  
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end
  
  def parent=(new_parent)
    
    parent.children.delete(self) unless parent.nil?
    @parent = new_parent
    unless new_parent.nil? || parent.children.include?(self)
      parent.children << self 
    end
    
  end
  
  def add_child(node)
    children.push(node) unless children.include?(node)
    node.parent = self
  end
  
  def remove_child(node)
    raise "The node is not the child" unless children.include?(node)
    children.delete(node)
    node.parent = nil
  end
    
  def dfs(target_value)
    return self if value == target_value 
    children.each do |child|
      found = child.dfs(target_value)
      return found unless found.nil?
    end
    nil 
  end
  
  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    nil
  end
end