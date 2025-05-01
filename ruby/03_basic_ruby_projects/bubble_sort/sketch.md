Consider an array of numbers, for example [4, 2, 5, 1, 6]. To sort them according to bubble sort, we go number by number, comparing the current one to the next. If the current one is greater than the next one, we swap them. Thus, in the first iteration we go from zero to the length of the array minus one, as there's no next to the last element.

After the first iteration the last element of the array should be sorted... or should it? Assume we have something like

```
[100, 1, 3, 6, 2, 9]
```

Let's do the first iteration. We start at zero, and keep going until the penultimate element of the array.

When i = 0, we compare a[0] and a[1], we notice a[0] > a[1], so we swap them and the array ends up like

```
[1, 100, 3, 6, 2, 9]
```

When i = 1 we notice the same thing, and end up with

```
[1, 3, 100, 6, 2, 9]
```

It will continue to be true for the rest of the elements, so we end up with

```
[1, 3, 6, 2, 9, 100]
```

Thus, if we had n unsorted elements at first, now we have n - 1. For every iteration the largest element will bubble up to where it belongs, so we can decrease the number of sorted elements by one.

There's something I'm not understanding. This works

```js
function sort(array) {
  let unsorted = array.length;

  while (unsorted !== 0) {
    for (let i = 0; i < unsorted; i++) {
      const current = array[i];
      const next = array[i + 1];

      if (current > next) {
        array[i] = next;
        array[i + 1] = current;
      }
    }

    unsorted--;
  }
}
```

but this doesn't

```ruby
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
```

what is more, if I put a log in the outer loop in both implementations, the js one logs the expected number of times, while the ruby does it only once.

---

I figured it out. I was confusing `unless` with `until`.