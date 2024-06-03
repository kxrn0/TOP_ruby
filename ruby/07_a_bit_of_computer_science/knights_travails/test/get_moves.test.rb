require_relative "../lib/get_moves"
require_relative "../lib/point"

size = 8
cell1 = Point.new 0, 0
cell2 = Point.new 7, 7
cell3 = Point.new 1, 3
cell4 = Point.new 4, 4

puts get_moves cell1, size
puts '_____________________'
puts get_moves cell2, size
puts '_____________________'
puts get_moves cell3, size
puts '_____________________'
puts get_moves cell4, size
puts '_____________________'