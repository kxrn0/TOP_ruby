require_relative "tree"

array = [2, 4, 6, 8, 10, 12, 14, 16]
tree = Tree.new array

puts tree.balanced?

tree.insert 0
tree.pretty_print
