def bubble_sort array
  unsorted = array.length

  while unsorted != 0
    j = 0
    while j < unsorted - 1
      if array[j + 1] < array[j]
        temp = array[j + 1]
        array[j + 1] = array[j]
        array[j] = temp
      end

      j += 1
    end

    unsorted -= 1
  end

  array
end

p bubble_sort [4,3,78,2,0,2]
