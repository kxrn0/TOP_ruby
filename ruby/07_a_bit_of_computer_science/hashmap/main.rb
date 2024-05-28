require_relative "lib/list.rb"
require_relative "lib/hashtable"

class Person
  attr_accessor :name, :age

  def initialize name, age
    @name = name
    @age = age
  end

  def to_s
    "name: #{@name}, age: #{@age}"
  end
end

people = HashTable.new

people.set "one", Person.new("One", 67)
people.set "two", Person.new("Two", 78)
people.set "three", Person.new("Three", 43)
people.set "four", Person.new("Four", 53)

puts people.to_s

