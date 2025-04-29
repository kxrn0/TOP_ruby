$1.$ Given a hash of family members, with the keys as the title and an array of names as the value, use Ruby's built in `select` method to gather only siblings' names into a new array.

```ruby
family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }
```

$A:$

```ruby
family = { uncles: ["bob", "joe", "steve"],
           sisters: ["jane", "jill", "beth"],
           brothers: ["frank", "rob", "david"],
           aunts: ["mary", "sally", "susan"] }

relevant = family.select do |title, members|
  if title == :brothers || title == :sisters
    true
  else
    false
  end
end

siblings = []

relevant.values.each { |members| siblings += members }

puts siblings

```

$2.$ Look at Ruby's merge method. Notice that it has two versions. What is the difference between `merge` and `merge!`? Write a program that uses both and illustrate the differences.

$A:$

`merge` creates a new array that is the merging of the two arrays involved in the operation, while `merge!` modifies the caller setting its value to the result of the merging.

In the program below `one` and `two` remain the same after the merging, and `merge` is given the value `{:a=>0, :b=>1, :c=>4, :d=>5, :e=>6}`

```ruby
one = {a: 0, b: 1, c: 3}
two = {c: 4, d: 5, e: 6}
merged = one.merge two
```

While in the program below `two` remains the same after the merging, but `one` ends up with the value `{:a=>0, :b=>1, :c=>4, :d=>5, :e=>6}`.

```ruby
one = {a: 0, b: 1, c: 3}
two = {c: 4, d: 5, e: 6}
one.merge! two
```

$3.$ Using some of Ruby's built in hash methods, write a program that loops through a hash and prints all of the keys. Then write a program that does the same thing, except printing the values. Finally write a program that prints both.

$A:$

```ruby
hs = { a: 0, b: 1, c: 2 }

hs.keys.each { |k| puts k }

hs.values.each { |v| puts v }

hs.each { |k, v| puts "#{k}: #{v}" }
```

$4.$ Given the following expression, how would you access the name of the person?

```ruby
person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}
```

$A:$

`person[:name]`

$5.$ What method could you use to find out if a hash contains a specific value in it? Write a program that verifies that the value is within the hash.

$A:$

There's the `has_value?` predicate, it can be used like this

```ruby
player = { health: 90, power: 50, tokens: 12, category: "merchant" }

puts player.has_value? "hero" # false
puts player.has_value? "merchant" # true
```

$6.$ Given the following code

```ruby
x = "hi there"
my_hash = {x: "some value"}
my_hash2 = {x => "some value"}
```

What is the difference between the two hashes that were created?

$A:$

The key of the first one is the symbol `:x`, while the key of the second one is the string `"hi there"`.

$7.$ If you see this error, what do you suspect is the most likely problem?

```
NoMethodError: undefined method `keys' for Array
```

(a) - We're missing keys in an array variable.

(b) - There's no method called `keys` for Array objects.

(c) - `keys` is an Array object, but it hasn't been defined yet.

(d) - There's an array of strings, and we are trying to get the string `keys` out of the array, but it doesn't exist.

$A:$

b.
