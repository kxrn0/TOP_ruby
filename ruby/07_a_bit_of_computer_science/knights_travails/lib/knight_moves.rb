# frozen_string_literal: true

require 'set'
require_relative 'cell'
require_relative 'queue'

def get_list(dest)
  path = []
  parent = dest.parent

  path.push dest

  until parent.nil?
    path.push parent
    parent = parent.parent
  end

  path.map(&:to_a).reverse
end

def add_items_to_queue(queue, neighbors, parent)
  neighbors.each do |neigh|
    neigh.parent = parent
    queue.enqueue neigh
  end
end

def valid_cell?(cell, visited)
  cell.x.between?(0, 7) && cell.y.between?(0, 7) && visited.include?(cell.to_s) == false
end

def check_cell(cell, visited, neighbors)
  return unless valid_cell? cell, visited

  neighbors.push cell
  visited.add cell
end

def find_free_neighbors(source, visited)
  dx = [-2, -2, 2, 2, -1, 1, -1, 1]
  dy = [1, -1, 1, -1, 2, 2, -2, -2]
  x, y = source.to_a
  neighbors = []

  dx.size.times do |idx|
    cell = Cell.new x + dx[idx], y + dy[idx]
    check_cell cell, visited, neighbors
  end

  neighbors
end

def find_path(queue, visited, target)
  until queue.empty?
    cell = queue.dequeue

    return get_list cell if cell == target

    neighbors = find_free_neighbors cell, visited

    add_items_to_queue queue, neighbors, cell
  end
end

def knight_travels(from, to)
  from = Cell.from_a from
  to = Cell.from_a to
  visited = Set.new
  queue = Queue.new

  queue.enqueue from
  visited.add from.to_s

  find_path queue, visited, to
end

p knight_travels [0, 0], [7, 7]
