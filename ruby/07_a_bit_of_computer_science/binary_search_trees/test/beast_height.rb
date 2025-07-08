# frozen_string_literal: true

require_relative '../lib/beast'

bst = Beast.new [30, 50, 90]

bst.insert 35
bst.insert 25
bst.insert 27
bst.insert 20
bst.insert 10

bst.pretty_print

puts "h: #{bst.height 30}"
