require_relative "../lib/find_path"
require_relative "../lib/point"

p1 = Point.new 0, 0
p2 = Point.new 3, 3
p3 = Point.new 7, 7
p4 = Point.new 4, 3
size = 8

puts find_path p1, p2, size
puts "-----------------------------"
puts find_path p2, p1, size
puts "-----------------------------"
puts find_path p1, p3, size
puts "-----------------------------"
puts find_path p2, p4, size