Consider an array of numbers, for example [4, 2, 5, 1, 6]. With bubble sort we go one by one, swapping the elements if they are out of order. How do we know when to stop? Maybe we can keep track of a variable `unsorted` that is initialized to the length of our array. Do we stop once this variable reaches zero? Let's assume so.

While `unsorted` is not zero

- go from zero to `unsorted`
 - compare the current element to the next one
 - if the current element is greater than the next one, swap them
- decrease `usorted` by one

