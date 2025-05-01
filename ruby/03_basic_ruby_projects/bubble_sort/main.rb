def bubble_sort(array)
  unsorted = array.length

  until unsorted == 0
    last = unsorted - 1

    (0...last).each do |i|
      curr_val = array[i]
      next_val = array[i + 1]

      if curr_val > next_val
        array[i] = next_val
        array[i + 1] = curr_val
      end
    end

    unsorted -= 1
  end

  array
end

p bubble_sort [4, 3, 78, 2, 0, 2]
