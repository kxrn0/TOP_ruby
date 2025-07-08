# frozen_string_literal: true

require_relative 'node'

# Linked list
class List
  attr_reader :head

  def initialize
    @head = nil
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

  def contains?(value)
    node = @head

    until node.nil?
      return true if value == node.value

      node = node.next_node
    end

    false
  end

  def find(value)
    index = 0
    node = @head

    until node.nil?
      return index if value == node.value

      index += 1
      node = node.next_node
    end
  end

  def to_s
    str = ''
    node = @head

    until node.nil?
      str += "( #{node.value} ) -> "

      node = node.next_node
    end

    str += 'nil'

    str
  end

  def insert_at(value, index)
    return prepend value if index.zero?

    parent, node = pair index

    insert_at_helper value, parent, node
  end

  def remove_at(index)
    return shift if index.zero?

    parent, node = pair index

    remove_at_helper parent, node
  end

  private

  def pair(index)
    parent = nil
    node = @head

    until node.nil? || index.zero?
      parent = node
      node = node.next_node

      index -= 1
    end

    [parent, node]
  end

  def sneed(value)
    @head = Node.new value, nil
  end

  def insert_at_helper(value, parent, node)
    raise 'index out of bounds' if node.nil?

    new_node = Node.new value, node

    parent.next_node = new_node
    new_node.next_node = node

    value
  end

  def remove_at_helper(parent, node)
    raise 'index out of bounds' if node.nil?

    parent.next_node = node.next_node
    node.next_node = nil

    node.value
  end

  def at_helper(node, index)
    return node&.value if node.nil? || index.zero?

    at_helper node.next_node, index - 1
  end
end
