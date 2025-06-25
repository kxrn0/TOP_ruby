# Merge Sort

To merge sort an array we first divide it into two halfs, sort each half separately, and then merge them.

There seem to be three basic steps, based on that sentence.

## Divide an array into two halfs

You start with an array like

```
[1, 2, 3, 4, 5]
```

and divide it to get

```
[1, 2], [3, 4, 5]
```

What ruby construct allowes us to do that? We can use ranges. We get the first half with a half open range, and the second one with a closed range.

```ruby
array = [1, 2, 3, 4, 5]
midpoint = array.size / 2
left_half = array[0...midpoint]
right_half = array[midpoint..array.size]
```

## Sort each half separately

To sort one half of the array we first divide it into two halfs, and sort each one separately. If we keep dividing there will be a point when the resulting array has one or zero elements. An array with one or zero elements can be considered sorted, so all that remains is to merge it with its other half.

## Merge the sorted halfs

Finally we merge the resulting arrays into another array. The way we do this is by comparing the first elements of each array, moving the smallest one to the target array and continuing until we have nothing else to add.

Say you have the arrays

```
A = [6, 15, 20]
B = [7, 10, 11, 23, 25, 26]
```

We create a target array

```
T = []
```

then we compare the first elements of both arrays, and add the smallest to the target array. We also remove this added element from its source.

```
A[0] => 6
B[0] => 7

6 < 7

T = [6]

A = [15, 20]
B = [7, 10, 11, 23, 25, 26]
```

We do it again

```
T = [6, 7]

A = [15, 20]
B = [10, 11, 23, 25, 26]
```

and again

```
T = [6, 7, 10]

A = [15, 20]
B = [11, 23, 25, 26]
```

again...

```
T = [6, 7, 10, 11]

A = [15, 20]
B = [23, 25, 26]
```

once more...

```
T = [6, 7, 10, 11, 15]

A = [20]
B = [23, 25, 26]
```

almost done...

```
T = [6, 7, 10, 11, 15, 20]

A = []
B = [23, 25, 26]
```

If at some point one of the arrays becomes empty, we dump the contents of the other array into the target array, and we are done.

```
T = [6, 7, 10, 11, 15, 20, 23, 25, 26]
```

## Pseudocode

```
merge_sort(array) {
  return array if array.size <= 1

  midpoint = Math.floor(array.size / 2)

  leftHalf = array[0...midpoint]
  rightHalf = array[midpoint..array.size]

  leftHalf = merge_sort(leftHalf)
  rightHalf = merge_sort(rightHalf)

  sorted = []

  until leftHalf.empty? || rightHalf.empty? {
    smallest = leftHalf[0] < rightHalf[0] ? leftHalf : rightHalf

    sorted.push smallest.shift
  }

  sorted = [...sorted, ...leftHalf, ...rightHalf]
}
```

I think that should work.
