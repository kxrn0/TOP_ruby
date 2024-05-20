def create_binary_search_tree(array)
  tree = { value: array[0], left: nil, right: nil }

  index = 1
  until index == array.size
    value = array[index]
    current = tree

    while true
      if current[:value] <= value
        if current[:right]
          current = current[:right]
        else
          right = { value:, left: nil, right: nil }

          current[:right] = right
          break
        end
      else
        if current[:left]
          current = current[:left]
        else
          left = { value:, left: nil, right: nil }

          current[:left] = left
          break
        end
      end
    end

    index += 1
  end

  tree
end

def breadth_first_search(tree)
  cute = []

  cute.push tree

  while cute.size != 0
    node = cute[0]

    yield node if block_given?

    cute.push node[:left] if node[:left]
    cute.push node[:right] if node[:right]

    cute.shift
  end
end

def depth_first_search_preorder(node, &block)
  return unless node

  block.call node
  depth_first_search_preorder node[:left], &block
  depth_first_search_preorder node[:right], &block
end

def depth_first_search_inorder(node, &block)
  return unless node

  depth_first_search_inorder node[:left], &block
  block.call node
  depth_first_search_inorder node[:right], &block
end

def depth_first_search_postorder(node, &block)
  return unless node

  depth_first_search_postorder node[:left], &block
  depth_first_search_postorder node[:right], &block
  block.call node
end

array = [5, 7, 1, 15, 9, 2, 14, 8, 7, 3]
tree = create_binary_search_tree array

depth_first_search_inorder(tree) { |node| puts node[:value] }
