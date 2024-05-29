require_relative "./person"
require_relative "../lib/hashtable"

people = HashTable.new

puts "keys:"
puts people.keys
puts "values:"
puts people.values
puts "entries:"
puts people.entries
puts "length:"
puts people.length
puts "hash:"
puts people

puts "------------------"

people.set "one", Person.new("One", 89)
people.set "two", Person.new("Two", 54)
people.set "three", Person.new("Three", 76)
people.set "four", Person.new("Four", 90)
people.set "five", Person.new("Five", 74)

puts "keys:"
puts people.keys
puts "values:"
puts people.values
puts "entries:"
puts people.entries
puts "length:"
puts people.length
puts "hash:"
puts people

puts "------------------"

people.set "three", Person.new("ThreeJS", 69)

puts "length:"
puts people.length
puts "hash:"
puts people

two = people.get "two"
six = people.get "six"

puts "two:"
puts two
puts "six:"
puts six
puts "has three:"
puts people.has? "three"
puts "has seven:"
puts people.has? "seven"

puts "------------------"

puts "removing four..."

r1 = people.remove "four"
r2 = people.remove "ten"

puts "four removed:"
puts r1
puts "ten removed:"
puts r2
puts "length:"
puts people.length
puts "hash:"
puts people

puts "clearing..."

people.clear

puts "hash:"
puts people