### $1.-$ What is a block?

$A:$

A block of code, basically an anonymous function.

### $2.-$ How is a block like a method?

$A:$

The code inside the block doesn't run when it's defined, but until it's called, like a method.

```ruby
def fun
  yield 1, 2
end

fun { |a, b| a + b }  # The block is defined here, but called inside the `fun` method.
```

### $3.-$ What are the two ways to declare a block?

$A:$

With curly braces

```ruby
def fun
  yield 1, 2
end

fun { |a, b| a + b }
```

and `do`/`end`

```ruby
def fun
  yield 3, 4
end

fun do |a, b|
  a2 = a ** 2
  b2 = b ** 2

  Math.sqrt(a2 + b2)
end
```

### $4.-$ How do you return data from a block?

$A:$

The last statement of a block is its return value.

```ruby
def fun n
  yield n
end

puts fun(5) { |n| n.even? ? "even!" : "odd!" }

puts (fun(9) do |n|
  sqrt = Math.sqrt(n)
  is_square = (sqrt % 1).zero?

  if is_square
    "#{n} is the square of #{sqrt.to_i}"
  else
    "#{n} is not special"
  end
end)

puts (fun(10) do |n|
  sqrt = Math.sqrt(n)
  is_square = (sqrt % 1).zero?

  if is_square
    "#{n} is the square of #{sqrt.to_i}"
  else
    "#{n} is not special"
  end
end)
```

The parentheses are needed in the last two examples, but not in the first two because precedence works differently depending on how the block is defined. With curly braces ruby assings the block to `fun`, however with `do`/`end` it throws a `LocalJumpError` without the parentheses. According to ClaudeGrokPT (Gemminy 2.5 Pro, actually. Claude gave me a completely wrong and misleading answer) it's because ruby interprets it as `(puts fun(5)) <block>`, causes the `yield` inside of `fun` to be called without a block, which throws an error, so the block is never even considered.

Another thing to note is that a `return` statement behaves unexpectedly. For example, this code

```ruby
def fun n
  yield n
end

puts fun(5) { |n| n.even? ? "even!" : "odd!" }

a = fun(9) do |n|
  sqrt = Math.sqrt(n)
  is_square = (sqrt % 1).zero?

  return "#{n} is the square of #{sqrt.to_i}" if is_square

  "#{n} is not special"
end

puts "hi"
puts a
```

Outputs only

```
odd!
```

It seems like the `return` statement of the block applies to the context it was defined in. If we change the block to a proc like this

```ruby
def fun n, pr
  pr.call n
end

pr = Proc.new do |n|
  sqrt = Math.sqrt(n)
  is_square = (sqrt % 1).zero?

  return "#{n} is the square of #{sqrt.to_i}" if is_square

  "#{n} is not special"
end

a = fun 9, pr

puts "hi"
puts a
```

we get no output, suggesting that `return` statements in procs behave like they seem to do in blocks, however the tutorial says that

> A proc object, however, returns from the context in which it is called. {...} If you return from a proc inside a method, the method is the context in which it was called and therefore it returns from the method before any of the other code below it is executed.

and they give the example

```ruby
def my_method
  a_proc = Proc.new { return }
  puts "this line will be printed"
  a_proc.call
  puts "this line is never reached"
end

my_method
#=> this line will be printed
```

which seems to do what it says, however if we modify the example like this

```ruby
def my_method a_proc
  puts "this line will be printed"
  a_proc.call
  puts "this line is never reached"
end

a_proc = Proc.new { return }

my_method a_proc

puts "bye"
```

we get the same output as above, which implies that the return statement applies to the top level context, where the proc was defined, rather than the `my_method`'s context, so the tutorial seems to be wrong.

### ${5.-} How can your methods collect the returned data from a block?

$A:$ With variables.

```ruby
def fun numbers
  squares = []

  numbers.each do |n|
    squares.push yield n
  end

  sum = squares.reduce(0) { |tot, curr| tot + curr }

  sum / numbers.size.to_f
end

nums = (1..10).to_a

result = fun(nums) { |n| n * n }

puts result
```

### $6.-$ What happens if you include a return statement in a block?

$A:$

The block returns from the context it's defined in, not where it is called.

I think the explanation of `return` statements in procks and blocks is wrong. The tutorial says that

> A proc object, however, returns from the context in which it is called

and gives the example

```ruby
def my_method
  a_proc = Proc.new { return }
  puts "this line will be printed"
  a_proc.call
  puts "this line is never reached"
end

my_method
#=> this line will be printed
```

but if we change the example to

```ruby
def my_method a_proc
  puts "this line will be printed"
  a_proc.call
  puts "this line is never reached"
end

a_proc = Proc.new { return }

my_method a_proc

puts "bye"
```

or to

```ruby
def my_method
  puts "this line will be printed"
  yield
  puts "this line is never reached"
end

my_method { return }

puts "bye"
```

the line `'bye'` never gets printed, suggesting that the return in the proc/block applies to the top leve context, which contradicts the tutorial which says that it applies to the `my_method` context.

### $7.-$ What does `yield` do?

$A:$

It calls the given block.

### $8.-$ How do you pass arguments to a block from within a method?

$A:$

We give them to `yield`.

### $9.-$ How do you check whether a block was actually passed in?

$A:$

With `block_given?`.

### $10.-$ What is a proc?

$A:$

A wrapper around a block, so it can be passed around like a variable.

A proc is very loose when it comes to parameters, it discards extra parameters, and assigns `nil` to the ones not given a value. It also supports default parameters.

As shown above, `return` statements apply to the context the proc was defined in, rather than where it's called.

### $11.-$ What is a lambda.

A special kind of proc, but with some differences. It returns from itself, rather than some other context.

```ruby
def fun numbers, lmd
  results = []

  numbers.each do |n|
    label = lmd.call n

    res = "#{n} is #{label}"

    results.push res
  end

  puts results
end

lmd = ->(n) do
  return "even!" if n.even?

  "odd!"
end

numbers = (1..10).to_a
fun numbers, lmd
```

It throws an error if the number of parameters given is not the one in the definition.

It acts as a closure.

```ruby
def fun lmd
  5.times { lmd.call }
end

n = 0

lmd = -> { n += 1 }

fun lmd

puts n
```

### $12.-$ What is the difference between a lambda and a proc?

$A:$

The way `return` works, and how strict they are with parameters.

### $13.-$ How do you convert a proc to a block?

$A:$

With the `&` operator.

```ruby
def fun
  puts yield 10
end

pr = Proc.new { |n| n + 1 }

fun &pr
```

### $14.-$ How do you convert a block to a proc?

$A:$

With the `&` operator in the parameter list of a method.

```ruby
def fun n, &pr
  puts pr.call n
end

fun(10) { |n| n + 1 }
```
