require_relative "../lib/tree"

numbers = Array.new(20) { rand 1..100 }
tree = Tree.new numbers

tree.pretty_print
puts "is tree balanced?: #{tree.balanced?}"
puts "level order:"
tree.level_order { |n| puts n }
puts "preorder:"
tree.preorder { |n| puts n }
puts "inorder:"
tree.inorder { |n| puts n }
puts "postorder:"
tree.postorder { |n| puts n }

10.times { tree.insert rand 100..1000 }

tree.pretty_print
puts "is tree balanced?: #{tree.balanced?}"
puts "rebalancing the tree..."
tree.rebalance
puts "is tree balanced? #{tree.balanced?}"
tree.pretty_print
puts "level order:"
tree.level_order { |n| puts n }
puts "preorder:"
tree.preorder { |n| puts n }
puts "inorder:"
tree.inorder { |n| puts n }
puts "postorder:"
tree.postorder { |n| puts n }