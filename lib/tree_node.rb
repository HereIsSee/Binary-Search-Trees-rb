# A tree node used for a binary tree
class TreeNode
  include Comparable
  attr_accessor :left, :right, :value

  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
  end

  def <=>(other)
    @value <=> other.value
  end
end
