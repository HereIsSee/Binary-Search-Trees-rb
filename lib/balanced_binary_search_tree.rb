require_relative 'tree_node'

class BalancedBinarySearchTree
  attr_accessor :root
  def initialize(array)
    array = array.sort.uniq
    @root = build_tree(array, 0, array.length-1)
  end

  def build_tree(array, start, ending)
    return nil if start > ending

    mid = (start + ending) / 2
    root = TreeNode.new(array[mid])

    root.left = build_tree(array, start, mid - 1)
    root.right = build_tree(array, mid + 1, ending)

    root
  end

  def insert(root, value)
    return puts "Value is already in tree" if value == root.value
  

    if value > root.value
      return root.right = TreeNode.new(value) if root.right.nil?
      return insert(root.right, value)
    end

    if value < root.value
      return root.left = TreeNode.new(value) if root.left.nil?
      return insert(root.left, value)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
 
end

tree = BalancedBinarySearchTree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
tree.insert(tree.root, 99)
puts "\n \n \n \n"
tree.pretty_print