# frozen_string_literal: true

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

items = (1..10).to_a
queue = Queue.new

items.each { |item| queue.enqueue item }

puts 'queue:'
puts queue

puts 'dequeueing:'
puts queue.dequeue until queue.empty?

puts 'queue:'
puts queue
