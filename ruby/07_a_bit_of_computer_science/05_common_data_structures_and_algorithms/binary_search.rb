# frozen_string_literal: true

# Test class
class Employee
  attr_reader :name, :age, :id

  def initialize(name, age, id)
    @name = name
    @age = age
    @id = id
  end

  def <=>(other)
    @id <=> other.id
  end

  def to_s
    "employee \##{@id}: #{@name}, #{@age}"
  end
end

def compute_halves(array)
  midpoint = array.size / 2

  [array[0...midpoint], array[midpoint..array.size]]
end

def merge(left_half, right_half)
  sorted = []

  until left_half.empty? || right_half.empty?
    comparison = left_half[0] <=> right_half[0]
    take_left = comparison == -1
    smallest = take_left ? left_half : right_half

    sorted.push smallest.shift
  end

  [*sorted, *left_half, *right_half]
end

def merge_sort(array)
  return array if array.size <= 1

  left_half, right_half = compute_halves array

  left_half = merge_sort left_half
  right_half = merge_sort right_half

  merge left_half, right_half
end

def check_last_item(item, &test)
  item if item.nil? || test.call(item).zero?
end

def search_rest(array, item, midpoint, result, &test)
  if result == -1
    binary_search array[(midpoint + 1)..array.size], &test
  elsif result == 1
    binary_search array[0...midpoint], &test
  else
    item
  end
end

def binary_search(array, &test)
  return check_last_item(array[0], &test) if array.size <= 1

  midpoint = array.size / 2
  item = array[midpoint]
  result = test.call item

  search_rest array, item, midpoint, result, &test
end

employees = [
  Employee.new('qwe', 72, 23),
  Employee.new('rty', 22, 17),
  Employee.new('uio', 34, 32),
  Employee.new('pas', 89, 47),
  Employee.new('dfg', 45, 56),
  Employee.new('hjk', 63, 90),
  Employee.new('lzx', 12, 50),
  Employee.new('cvb', 78, 10),
  Employee.new('nmq', 30, 66),
  Employee.new('wer', 18, 15)
]
sorted_employees = merge_sort employees
id = 66
test = proc do |employee|
  if employee.id == id
    0
  elsif employee.id < id
    -1
  else
    1
  end
end
employee = binary_search sorted_employees, &test

puts employee
