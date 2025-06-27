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

# Node
class QNode
  attr_accessor :data, :succ, :pred

  def initialize(data, succ, pred)
    @data = data
    @succ = succ
    @pred = pred
  end
end

# Queue
class Queue
  def initialize
    @front = nil
    @back = nil
  end

  def enqueue(item)
    return add_first_node item if @front.nil?

    node = QNode.new item, @back, nil

    @back.pred = node
    @back = node
  end

  def dequeue
    return handle_single_item_case if @front == @back

    node = @front
    pred = node.pred

    node.pred = nil
    pred.succ = nil

    @front = pred

    node.data
  end

  def empty?
    @front.nil?
  end

  def to_s
    str = ''
    node = @front

    until node.nil?
      str += "#{node.data}, "

      node = node.pred
    end

    str
  end

  private

  def add_first_node(item)
    node = QNode.new item, nil, nil

    @front = node
    @back = node
  end

  def handle_single_item_case
    data = @front&.data

    @front = nil
    @back = nil

    data
  end
end

# Node
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

  def breadth_first_search(&test)
    queue = Queue.new

    queue.enqueue @root

    until queue.empty?
      node = queue.dequeue
      data = node.data

      return data if test.call data

      queue.enqueue node.left unless node.left.nil?
      queue.enqueue node.right unless node.right.nil?
    end
  end

  private

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
bst = Beast.new

employees.each { |employee| bst.append employee }

bst.breadth_first_search do |data|
  puts data

  false
end

puts '----------'

id = 47
employee = bst.breadth_first_search { |e| e.id == id }

puts employee
