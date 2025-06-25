### $1.-$ What is pattern matching?

$A:$

Making desitions based on whether or not a value has a certain shape.

### $2.-$ What is the difference between array patterns and hash patterns?

$A:$

Array patterns match the whole array, while hash patterns match a hash even if only part of the pattern matches the hash.

In the array pattern you match againts the values in the order they are

```ruby
arr = [1, 2, 3, "str"]

case arr
in [a]
  puts "single item array: #{a}"
in [first, Integer, Integer, last]
  puts "first: #{first}, last: #{last}"
else
  puts "no match"
end
```

While with the hash pattern you match the keys instead of the values

```ruby
config = { level: 'user', password: '123abc', aliases: %w[anon larbs meteor] }

case config
in password:, aliases: [name, *]
  puts name
  puts password
end
```

### $3.-$ What is the variable pattern match?

$A:$

Is a pattern that assigns the matched value to a variable. For example, below we assign a value to `username` with this pattern.

```ruby
data = { personal_details: { name: 'anon', age: 45 }, bank_details: { balance: 50 } }

case data
in personal_details: { name: username }
  puts username
end
```

### $4.-$ What are the different ways of pattern matching on an array?

$A:$

We can match by the exact elements

```ruby
arr = [1, 2, 3]

case arr
in [1, 2, 3]
  puts "match"
in [3, 2, 1]
  puts "not reached"
end
```

against the types

```ruby
arr = ['string', 100, true]

case arr
in [String => str, Integer => int, (TrueClass | FalseClass) => bool]
  puts "match: #{str}, #{int}, #{bool}"
else
  puts 'no match'
end
```

we can ignore a portion of the array with splat

```ruby
arr = [1, 2, 3, 4, 5, 6]

range = (5..10)

case arr
in [*, a, b] if range.include?(a) && range.include?(b) && a < b
  puts "#{a}, #{b}"
else
  puts 'no match'
end
```

### $5.-$ Explain the find pattern.

$A:$

We put `*` before and after the pattern we want to match.

```ruby
arr = [1, 2, true, "strong", false, 5, 6, 7]

case arr
in [*, String => str, (TrueClass | FalseClass) => bool, Integer => int, *]
  puts "#{str}, #{bool}, #{int}"
else
  puts "no match"
end
```
