=begin
  1.- What is the difference between a stack and a queue?

  A stack is LIFO, and a queue is FIFO.
=end

=begin
  2.- How would you implement a queue in Ruby?

  As follows
=end

class Queue
  def initialize
    @items = []
  end

  def enqueue(item)
    @items.push item
  end

  def dequeue
    @items.shift
  end

  def to_s
    @items.join ","
  end
end

queue = Queue.new

10.times { |n| queue.enqueue n }

puts queue

3.times { queue.dequeue }

puts queue

=begin
  3.- What is a linked list? What is a node?

  A data structure that chains objects together. Each object has a field for data, and one or two for the next and previous nodes in the list respectively.
  Each object is refered to as a node.
=end

=begin
  4.- Which recursive problem solving method/algorithm design principle does binary search implement?

  Divide and conquer.
=end

=begin
  5.- What abstract data type would you use for to defer/store nodes in a breadth first tree traversal?

  A queue.
=end

=begin
  6.- What abstract data type would you use to defer/store nodes in a depth first tree traversal?

  A stack.
=end
