require_relative 'tree_node'

# A balanced binary tree class done for practice :P
class BalancedBinarySearchTree
  attr_accessor :root

  def initialize(array)
    array = array.sort.uniq
    @root = build_tree(array, 0, array.length - 1)
  end

  def build_tree(array, start, ending)
    return nil if start > ending

    mid = (start + ending) / 2
    root = TreeNode.new(array[mid])

    root.left = build_tree(array, start, mid - 1)
    root.right = build_tree(array, mid + 1, ending)

    root
  end

  def insert(value)
    insert_recursive(value)
    rebalance unless balanced?
  end

  def insert_recursive(value, root = @root)
    return puts 'Value is already in tree' if value == root.value

    if value > root.value
      return root.right = TreeNode.new(value) if root.right.nil?

      insert_recursive(value, root.right)
    elsif value < root.value
      return root.left = TreeNode.new(value) if root.left.nil?

      insert_recursive(value, root.left)
    end
  end

  def delete(value)
    delete_recursive(value)
    rebalance unless balanced?
  end

  def delete_recursive(value, root = @root)
    return root if root.nil?

    if root.value > value
      root.left = delete_recursive(value, root.left)

    elsif root.value < value
      root.right = delete_recursive(value, root.right)
    else
      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      end

      if root.right.nil?
        temp = root.left
        root = nil
        return temp
      end

      succ = get_successor(root)
      root.value = succ.value
      root.right = delete_recursive(succ.value, root.right)
    end
    root
  end

  def get_successor(curr)
    curr = curr.right
    curr = curr.left until curr.nil? || curr.left.nil?
    curr
  end

  def find(value, root = @root)
    return root if root.nil?
    return root if root.value == value

    if root.value > value
      find(value, root.left)
    elsif root.value < value
      find(value, root.right)
    end
  end

  def level_order(root = @root)
    return if root.nil?

    queue = [root]
    result = []

    until queue.empty?
      current = queue.shift

      if block_given?
        yield current
      else
        result << current.value
      end

      queue.push(current.left) if current.left
      queue.push(current.right) if current.right
    end

    result unless block_given? # Return the result array if no block is given
  end

  def inorder(root = @root, array = [], &block)
    return array if root.nil?

    inorder(root.left, array, &block)

    yield root if block_given?
    array << root.value

    inorder(root.right, array, &block)

    array unless block_given?
  end

  def preorder(root = @root, array = [], &block)
    return array if root.nil?

    yield root if block_given?
    array << root.value

    preorder(root.left, array, &block)
    preorder(root.right, array, &block)

    array unless block_given?
  end

  def postorder(root = @root, array = [], &block)
    return array if root.nil?

    postorder(root.left, array, &block)
    postorder(root.right, array, &block)

    yield root if block_given?
    array << root.value

    array unless block_given?
  end

  def height(node)
    return 0 if node.nil?

    1 + [height(node.left), height(node.right)].max
  end

  def depth(node, root = @root, current_depth = 0)
    return -1 if root.nil? || node.nil?
    return current_depth if root == node

    if node.value < root.value
      depth(node, root.left, current_depth + 1)
    elsif node.value > root.value
      depth(node, root.right, current_depth + 1)
    else

      -1
    end
  end

  def balanced?(root = @root)
    return true if root.nil?

    left_tree_height = height(root.left)
    right_tree_height = height(root.right)

    return true if ((left_tree_height - right_tree_height).abs <= 1) && balanced?(root.left) && balanced?(root.right)

    false
  end

  def rebalance
    array = inorder
    @root = build_tree(array, 0, array.length - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) unless node.right.nil?
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) unless node.left.nil?
  end
end
