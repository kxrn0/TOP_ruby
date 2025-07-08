# frozen_string_literal: true

require_relative 'node'

# Linked list
class List
  attr_reader :head

  def initialize
    @head = nil
  end

  def empty?
    @head.nil?
  end

  def each(&block)
    node = @head

    until node.nil?
      block.call node.value

      node = node.next_node
    end
  end

  def append(value)
    return sneed value if @head.nil?

    node = @head

    node = node.next_node until node.next_node.nil?

    node.next_node = Node.new value, nil
  end

  def prepend(value)
    @head = Node.new value, @head
  end

  def size
    count = 0
    node = @head

    until node.nil?
      node = node.next_node
      count += 1
    end

    count
  end

  def tail
    return nil if @head.nil?

    node = @head

    node = node.next_node until node.next_node.nil?

    node.value
  end

  def at(index)
    at_helper @head, index
  end

  def pop
    parent = @head
    node = parent.next_node

    until node.next_node.nil?
      parent = node
      node = node.next_node
    end

    parent&.next_node = nil

    @head = nil if parent == @head

    node&.value
  end

  def shift
    node = @head

    @head = node&.next_node

    node&.next_node = nil

    node.value
  end

  def find(&test)
    node = @head

    until node.nil?
      value = node.value
      return value if test.call value

      node = node.next_node
    end
  end

  def has?(&test)
    node = @head

    until node.nil?

      return true if test.call node.value

      node = node.next_node
    end

    false
  end

  def remove(&test)
    parent, node = find_offending_node(&test)

    return if node.nil?

    if parent.nil?
      @head = nil
    else
      parent&.next_node = node.next_node
      node.next_node = nil
    end

    node.value
  end

  private

  def find_offending_node(&test)
    found = false
    parent = nil
    node = @head

    until node.nil? || found
      found = test.call node.value

      break if found

      parent = node
      node = node.next_node
    end

    [parent, node]
  end

  def sneed(value)
    @head = Node.new value, nil
  end

  def at_helper(node, index)
    return node&.value if node.nil? || index.zero?

    at_helper node.next_node, index - 1
  end
end
