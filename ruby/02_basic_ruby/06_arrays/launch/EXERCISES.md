$1.$ Below we have given you an array and a number. Write a program that checks if the number appears in the array.

```ruby
arr = [1, 3, 5, 7, 9, 11]
number = 3
```

$A:$

```ruby
arr = [1, 3, 5, 7, 9, 11]
number = 3

exists = arr.include? number

if exists
  puts "exists"
else
  puts "doesn't exist"
end
```

$2.$ What will the following programs return? What is the value of `arr` after `each`?

1.

```ruby
arr = ["b", "a"]
arr = arr.product(Array(1..3))
arr.first.delete(arr.first.last)
```

2.

```ruby
arr = ["b", "a"]
arr = arr.product([Array(1..3)])
arr.first.delete(arr.first.last)
```

$A:$

1.

The first line sets `arr` to `["b", "a"]`. The second one finds the product between it and `[1, 2, 3]`, which is

```ruby
[["b", 1], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]
```

the third line finds the first element of the array above and it deletes from it its last element. The first element is `["b", 1]`, the element we want to delete from here is `1`, so we end up with `["b"]` being the first element of `arr`, which makes it look like this

```ruby
[["b"], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]
```

and the last line returns the the result of `delete`, which is 1.

2.

The first line is the same as the first line in the previous program. In the second line we find the product between `["b", "a"]`, and `[[1, 2, 3]]`, which is

```ruby
[["b", [1, 2, 3]], ["a", [1, 2, 3]]]
```

In the third line we get the first element of `arr`, which is `["b", [1, 2, 3]]`, and we delete from it the last element of the first element of `arr`, which is again `["b", [1, 2, 3]]`, that last element being `[1, 2, 3]`, so the first element of `arr` ends up being `["b"]`, and `arr` ends up looking like this

```ruby
[["b"], ["a", [1, 2, 3]]]
```

The return value of the last line is the return of `delete`, so `[1, 2, 3]`.

$3.$ How do you return the word "example" from the following array?

```ruby
arr = [["test", "hello", "world"],["example", "mem"]]
```

$A:$

`arr[1][0]`

$4.$ What does each method return in the following example?

```ruby
arr = [15, 7, 18, 5, 12, 8, 5, 1]

arr.index(5)

arr.index[5]

arr[5]
```

$A:$

```ruby
arr = [15, 7, 18, 5, 12, 8, 5, 1]

arr.index(5)  # 3

arr.index[5]  # error

arr[5]  # 8
```

$5.$ What is the value of `a`, `b`, and `c` in the following program?

```ruby
string = "Welcome to America!"
a = string[6]
b = string[11]
c = string[19]
```

$A:$

```ruby
a # e
b # A
c # nil
```

$6.$ You run the following code

```ruby
names = ['bob', 'joe', 'susan', 'margaret']
names['margaret'] = 'jody'
```

and get the error message

```
TypeError: no implicit conversion of String into Integer
  from (irb):2:in `[]='
  from (irb):2
  from /Users/username/.rvm/rubies/ruby-2.5.3/bin/irb:12:in `<main>'
```

What is the problem and how can it be fixed?

$A:$

Arrays are indexed with integers, not strings, so it fails in the second line. Looks like the program tries to replace one value with another, this could be done with

```ruby
names = ['bob', 'joe', 'susan', 'margaret']
index = names.index "margaret"

if index
  names[index] = "jody"
end
```

$7.$ Use the `each_with_index` method to iterate through an array of your creation that prints each index and value of the array.

$A:$

```ruby
numbers = [0, 1, 2]
numbers.each_with_index do |number, index|
  puts "number: #{number}, index: #{index}"
end
```

$8.$ Write a program that iterates over an array and builds a new array that is the result of incrementing each value in the original array by a value of 2. You should have two arrays at the end of this program, the original array, and the new array you've created. Print both arrays to the screen using the `p` method instead of `puts`.

$A:$

```ruby
numbers = [1, 2, 3]
incd = numbers.map { |n| n + 2 }

p numbers
p incd
```
