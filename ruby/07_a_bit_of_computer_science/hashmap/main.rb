require_relative "list.rb"

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

people = List.new

people.append Person.new "One", 78
people.append Person.new "Two", 89
people.append Person.new "Three", 90
people.append Person.new "Four", 67
people.append Person.new "Five", 56

people.put(Person.new "Zero", 66) {|p| p.name == "Three"}

puts people
