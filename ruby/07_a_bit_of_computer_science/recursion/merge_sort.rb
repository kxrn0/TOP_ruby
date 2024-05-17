def merge a, b
  merged = []
  aIndex = 0
  bIndex = 0

  (a.size + b.size).times do 
    if b.size == bIndex
      merged.push a[aIndex]
      
      aIndex += 1
    elsif a.size == aIndex
      merged.push b[bIndex]

      bIndex += 1
    elsif a[aIndex] < b[bIndex]
      merged.push a[aIndex]
      
      aIndex += 1
    else
      merged.push b[bIndex]

      bIndex += 1
    end
  end

  merged
end

def merge_sort array
  return array if array.length == 1

  left = merge_sort array[0, array.size / 2]
  right = merge_sort array[array.size / 2, array.size]

  merge left, right
end

puts merge_sort [3, 2, 1, 13, 8, 5, 0, 1]
puts "-----------------------"
puts merge_sort [105, 79, 100, 110]