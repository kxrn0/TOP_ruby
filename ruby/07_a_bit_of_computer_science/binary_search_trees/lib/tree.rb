require_relative "node"

class Tree
  def initialize(array)
    raise "No elements provided!" if array.size == 0

    sorted = array.uniq.sort
    @root = Tree.build_tree sorted
  end

  def insert(item)
    temp = @root

    while temp
      if item < temp.data
        if temp.left.nil?
          node = Node.new item

          return temp.left = node
        else
          temp = temp.left
        end
      elsif item > temp.data
        if temp.right.nil?
          node = Node.new item

          return temp.right = node
        else
          temp = temp.right
        end
      else
        return
      end
    end
  end

  def delete(item)
    Tree.delete_node @root, item
  end

  def find(item)
    proc = Proc.new { |node| return node if node.data == item }
    Tree.breadth_traversal @root, proc
  end

  def level_order(&block)
    Tree.level_order_traverse [@root], &block
  end

  def preorder(&block)
    Tree.preorder_traversal @root, &block
  end

  def inorder(&block)
    Tree.inorder_traversal @root, &block
  end

  def postorder(&block)
    Tree.postorder_traversal @root, &block
  end

  def depth(node)
    Tree.node_depth @root, node.data
  end

  def height(node)
    height = { value: 0 }

    Tree.node_height @root, node.data, height

    height[:value]
  end

  def balanced?
    Tree.tree_balanced? @root
  end
  
  def rebalance
    items = []
    inorder { |node| items.push node.data }

    @root = Tree.build_tree items
  end

  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
  end

  def self.build_tree(array)
    return unless array.size > 0

    middle = array.size / 2
    head = Node.new array[middle]

    head.left = Tree.build_tree array[0, middle]
    head.right = Tree.build_tree array[middle + 1, array.size]

    head
  end

  def self.tree_balanced?(node)
    return true unless node

    leftHeight = Tree.tree_height node.left
    rightHeight = Tree.tree_height node.right

    if 
      ((leftHeight - rightHeight).abs <= 1) && 
      tree_balanced?(node.left) && 
      tree_balanced?(node.right)
      return true
    end

    false
  end

  def self.tree_height(node)
    return 0 unless node

    1 + [tree_height(node.left), tree_height(node.right)].max
  end

  def self.node_height(node, item, height)
    return -1 unless node

    leftHeight = node_height node.left, item, height
    rightHeight = node_height node.right, item, height

    max = [leftHeight, rightHeight].max + 1

    if node.data == item
      height[:value] = max
    end

    max
  end

  def self.node_depth(node, item)
    return -1 unless node

    dist = -1
    if node.data == item
      return dist + 1
    end

    dist = node_depth node.left, item
    if dist >= 0
      return dist + 1
    end

    dist = node_depth node.right, item
    if dist >= 0
      return dist + 1
    end

    dist
  end

  def self.preorder_traversal(node, &block)
    return nil unless node

    block.call node
    preorder_traversal node.left, &block
    preorder_traversal node.right, &block
  end

  def self.inorder_traversal(node, &block)
    return nil unless node

    inorder_traversal node.left, &block
    block.call node
    inorder_traversal node.right, &block
  end

  def self.postorder_traversal(node, &block)
    return nil unless node

    postorder_traversal node.left, &block
    postorder_traversal node.right, &block
    block.call node
  end

  def self.level_order_traverse(cute, &block)
    return nil if cute.empty?

    node = cute.shift

    block.call node

    cute.push node.left if node.left
    cute.push node.right if node.right

    traverse cute, &block
  end

  def self.breadth_traversal(tree, proc)
    return nil unless tree

    cute = []

    cute.push tree
    until cute.size == 0
      node = cute[0]

      proc.call node

      cute.push node.left unless node.left.nil?
      cute.push node.right unless node.right.nil?

      cute.shift
    end
  end

  def self.delete_node(node, item)
    return node unless node

    if item < node.data
      node.left = delete_node node.left, item

      return node
    elsif node.data < item
      node.right = delete_node node.right, item

      return node
    end

    if node.left.nil?
      return node.right
    elsif node.right.nil?
      return node.left
    end

    succParent = node
    succ = node.right
    until succ.left.nil?
      succParent = succ
      succ = succ.left
    end

    node.data = succ.data

    if succParent.left.equal? succ
      succParent.left = succ.right
    else
      succParent.right = succ.right
    end

    return node
  end
end
