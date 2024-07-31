require_relative 'lib/balanced_binary_search_tree'

tree = BalancedBinarySearchTree.new((Array.new(15) { rand(1..100) }))

tree.pretty_print
puts tree.balanced?

p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder
