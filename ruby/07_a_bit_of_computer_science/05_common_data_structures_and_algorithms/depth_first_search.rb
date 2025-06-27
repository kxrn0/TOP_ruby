# frozen_string_literal: true

# Test class
class Employee
  attr_reader :name, :age, :id

  def initialize(name, age, id)
    @name = name
    @age = age
    @id = id
  end

  def <(other)
    @id < other.id
  end

  def to_s
    "employee \##{@id}: #{@name}, #{@age}"
  end
end

# Binary Tree Node
class BNode
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# Binary Search Tree
class Beast
  def initialize
    @root = nil
  end

  def append(data)
    return @root = BNode.new(data) if @root.nil?

    node = @root

    loop do
      node = add_node data, node

      break if node.nil?
    end
  end

  def inorder_search(&test)
    stack = []
    node = @root

    until node.nil? && stack.empty?
      stack_nodes stack, node

      node = stack.pop

      data = node.data

      return data if test.call data

      node = node.right
    end
  end

  private

  def stack_nodes(stack, node)
    until node.nil?
      stack.push node
      node = node.left
    end
  end

  def add_node(data, node)
    if data < node.data
      if node.left.nil?
        node.left = BNode.new data

        nil
      else
        node.left
      end
    elsif node.right.nil?
      node.right = BNode.new data

      nil
    else
      node.right
    end
  end
end

employees = [
  Employee.new('qwe', 72, 3),
  Employee.new('rty', 22, 7),
  Employee.new('uio', 34, 2),
  Employee.new('pas', 89, 1),
  Employee.new('dfg', 45, 5),
  Employee.new('hjk', 63, 4),
  Employee.new('lzx', 12, 12),
  Employee.new('cvb', 78, 6),
  Employee.new('nmq', 30, 10)
]
bst = Beast.new

employees.each { |e| bst.append e }

bst.inorder_search do |e|
  puts e

  false
end

id = 5
employee = bst.inorder_search { |e| e.id == id }

puts '---------'
puts employee
