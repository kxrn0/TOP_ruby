# frozen_string_literal: true

def compute_halves(array)
  midpoint = array.size / 2

  [array[0...midpoint], array[midpoint..array.size]]
end

def merge(left_half, right_half)
  sorted = []

  until left_half.empty? || right_half.empty?
    smallest = left_half[0] < right_half[0] ? left_half : right_half

    sorted.push smallest.shift
  end

  [*sorted, *left_half, *right_half]
end

def merge_sort(array)
  return array if array.size <= 1

  left_half, right_half = compute_halves array

  left_half = merge_sort left_half
  right_half = merge_sort right_half

  merge left_half, right_half
end

p merge_sort [3, 2, 1, 13, 8, 5, 0, 1]
p merge_sort [105, 79, 100, 110]
p merge_sort [6, 2, 9, 0, 7]
p merge_sort [6, 2, 9, 0, 9, 7]
p merge_sort [2]
p merge_sort []
