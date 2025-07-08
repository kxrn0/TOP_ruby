# frozen_string_literal: true

require_relative '../lib/beast'

# bst = Beast.new [1, 2, 3, 4, 5, 6, 7]
bst = Beast.new [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

puts 'beast:'
bst.pretty_print

puts 'inserting 100 and 200...'
bst.insert 100
bst.insert 200

puts 'beast:'
bst.pretty_print

puts 'deleting 67...'
bst.delete 67

puts 'beast:'
bst.pretty_print

puts 'finding 9'
onde = bst.find 9

puts onde

bst.level_order { |n| print "#{n}, " }

puts 'inorder...'

puts 'with block...'
bst.inorder { |n| puts n }

puts 'without block...'
values = bst.inorder
puts values

puts "depth of 100: #{bst.height 100}"
puts "depth of 4: #{bst.height 4}"
puts "depth of 1: #{bst.height 1}"
puts "depth of 3: #{bst.height 3}"

bst.pretty_print

puts "depth of 200: #{bst.depth 200}"
puts "depth of 5: #{bst.depth 5}"
puts "depth of 8: #{bst.depth 8}"
puts "depth of 2: #{bst.depth 2}"

puts "is the tree balanced? #{bst.balanced?}"

puts 'appending 150...'

bst.insert 150

bst.pretty_print

puts "is the tree balanced? #{bst.balanced?}"

puts 'inserting (10..20)...'

(10..20).each { |n| bst.insert n }

bst.pretty_print

puts "is the tree balanced? #{bst.balanced?}"

puts 'rebalancing...'

bst.rebalance

bst.pretty_print
