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