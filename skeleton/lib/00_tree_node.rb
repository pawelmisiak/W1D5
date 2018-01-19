require "byebug"
class PolyTreeNode
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
    # debugger
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