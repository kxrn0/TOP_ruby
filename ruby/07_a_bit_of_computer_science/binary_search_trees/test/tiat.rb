# frozen_string_literal: true

require_relative '../lib/beast'

bst = Beast.new(Array.new(15) { rand(1..100) })

bst.pretty_print

puts 'level order:'
puts bst.level_order

puts 'preorder:'
puts bst.preorder

puts 'inorder:'
puts bst.inorder

puts 'postorder:'
puts bst.postorder

puts 'unbalancing...'

(110..120).each { |n| bst.insert n }

bst.pretty_print

puts "is the tree balanced: #{bst.balanced?}"

puts 'rebalancing the tree...'

bst.rebalance

bst.pretty_print

puts "is the tree balanced: #{bst.balanced?}"

puts 'level order:'
puts bst.level_order

puts 'preorder:'
puts bst.preorder

puts 'inorder:'
puts bst.inorder

puts 'postorder:'
puts bst.postorder
