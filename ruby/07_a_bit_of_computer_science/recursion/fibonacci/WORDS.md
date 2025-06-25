# Fibonacci

```ruby
def fibonacci position
  if position <= 0
    0
  elsif position == 1
    1
  else
    fobonacci(position - 1) + fibonacci(position - 2)
  end
end
```

It works, however it's not very efficient. It's noticeably slow at just 35. We can increase performance by doing some caching.

```ruby
def fibonacci(position, cache = [0, 1])
  raise "position can't be negative" if position.negative?

  cached_value = cache[position]

  if cached_value.nil?
    value = fibonacci(position - 1, cache) + fibonacci(position - 2, cache)

    cache.push value

    value
  else
    cached_value
  end
end
```
