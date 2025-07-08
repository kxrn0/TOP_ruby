# frozen_string_literal: true

require_relative 'bnode'
require_relative 'queue'

# Binary Search Tree
class Beast
  def initialize(array)
    @root = build_tree array
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    insert_helper @root, value
  end

  def delete(value)
    delete_helper @root, value
  end

  def find(value)
    node = @root

    until node.nil?
      if value == node.value
        return node
      elsif value < node.value
        node = node.left
      else
        node = node.right
      end
    end
  end

  def depth(value)
    depth_helper @root, value
  end

  def level_order(&block)
    values = block_given? ? nil : []
    queue = Queue.new

    queue.enqueue @root

    until queue.empty?
      node = queue.dequeue
      value = node.value

      block.call value if block_given?
      values&.push value

      queue.enqueue node.left unless node.left.nil?
      queue.enqueue node.right unless node.right.nil?
    end

    values
  end

  def preorder(&block)
    values = block_given? ? nil : []
    edure = block_given? ? block : proc { |v| values.push v }

    preorder_helper @root, edure

    values
  end

  def inorder(&block)
    values = block_given? ? nil : []
    edure = block_given? ? block : proc { |v| values.push v }

    inorder_helper @root, edure

    values
  end

  def postorder(&block)
    values = block_given? ? nil : []
    edure = block_given? ? block : proc { |v| values.push v }

    postorder_helper @root, edure

    values
  end

  def height(value)
    node = find value

    return 0 if node.nil?

    height_helper node
  end

  def balanced?
    balanced_helper @root
  end

  def rebalance
    items = inorder

    @root = build_tree items
  end

  private

  def height_diff(node)
    left = node.left.nil? ? 0 : height(node.left.value)
    right = node.right.nil? ? 0 : height(node.right.value)

    (left - right).abs
  end

  def balanced_helper(node)
    return true if node.nil?

    diff = height_diff node

    return false if diff > 1

    balanced_helper(node.left) && balanced_helper(node.right)
  end

  def depth_helper(node, value)
    return -1 if node.nil?

    dist = -1

    found = node.value == value ||
            (dist = depth_helper(node.left, value)) >= 0 ||
            (dist = depth_helper(node.right, value)) >= 0

    return dist + 1 if found

    dist
  end

  def height_helper(node)
    return -1 if node.nil?

    1 + [height_helper(node.left), height_helper(node.right)].max
  end

  def preorder_helper(node, edure)
    return if node.nil?

    edure.call node.value

    preorder_helper node.left, edure
    preorder_helper node.right, edure
  end

  def inorder_helper(node, edure)
    return if node.nil?

    inorder_helper node.left, edure

    edure.call node.value

    inorder_helper node.right, edure
  end

  def postorder_helper(node, edure)
    return if node.nil?

    postorder_helper node.left, edure
    postorder_helper node.right, edure

    edure.call node.value
  end

  def insert_helper(root, value)
    return BNode.new value if root.nil?

    return root if root.value == value

    if value < root.value
      root.left = insert_helper root.left, value
    else
      root.right = insert_helper root.right, value
    end

    root
  end

  def successor(current)
    current = current.right

    current = current.left until current.nil? || current.left.nil?

    current
  end

  def delete_helper(root, value)
    return root if root.nil?

    if root.value > value
      root.left = delete_helper root.left, value
    elsif root.value < value
      root.right = delete_helper root.right, value
    else
      return root.right if root.left.nil?

      return root.left if root.right.nil?

      succ = successor root
      root.value = succ.value
      root.right = delete_helper root.right, succ.value
    end

    root
  end

  def build_tree(array)
    array = array.uniq.sort

    sorted_array_to_beast array, 0, array.size
  end

  def sorted_array_to_beast(array, from, to)
    return nil if from >= array.size || from > to

    mid = from + (to - from) / 2
    root = BNode.new array[mid]

    root.left = sorted_array_to_beast array, from, mid - 1
    root.right = sorted_array_to_beast array, mid + 1, to

    root
  end
end
