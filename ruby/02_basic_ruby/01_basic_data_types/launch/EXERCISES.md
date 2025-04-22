$1.$ Add two strings together that, when concatenated, return your first and last name as your full name in one string.

$A:$

```ruby
first = "Ruby"
last = "OnRails"
full_name = "#{first} #{last}"
```

$2.$ Use the modulo operator, division, or a combination of both to take a four digit number, and find the digit in the

1. thousands place
2. hundreds place
3. tens place
4. ones place

$A:$

Consider the number 7843. Imagine we can somehow get the ones, so we have 3, and we put it in a box; `places = [3]`. Since we already have the ones, we can get rid of that part. We can divide by 10, and since integers truncate we get 7843 / 10 = 784. We get the ones of this new number, and we put them in the box; `places = [3, 4]`. We can again divide by ten to get 784 / 10 = 78. We get the ones; `places = [3, 4, 8]`, divide, 78 / 10 = 7. We get the ones, `places = [3, 4, 8, 7]`, divide 7 / 10 = 0, and we are done. We have the digits in reverse, and we can get the number back by multiplying the number by ten to the index the number is in;

```
3 * 10 ** 0 + 4 * 10 ** 1 + 8 * 10 ** 2 + 7 * 10 ** 3
```

```ruby
def decompose(number)
  places = []

  while number > 0
    place = number % 10

    places.push place

    number /= 10
  end

  places
end
```

$3.$ Write a program that uses a hash to store a list of movie titles with the year they came out. Then use `puts` to make the program print out the year of each movie to the screen.

$A:$

```ruby
screening_years = { "VIM Invaders": 1972, "The Church of Emacs": 1990, "The JavaScript Menace": 2008 }

screening_years.each_value { |year| puts year }
```

$4.$ Use the dates from the previous example and store them in an array. Then make your program output the same things as in exercise 3.

$A:$

```ruby
dates = [1972, 1990, 2008]

dates.each { |date| puts date }
```

$5.$ Write a program that outputs the factorial of the numbers 5, 6, 7, and 8.

$A:$

```ruby
def factorial number
  result = 1

  (1..number).do |i|
    result *= i
  end

  result
end
```

$6.$ Write a program that calculates the squares of three float numbers of your choosing, and outputs the result to the screen.

$A:$

```ruby
def square x
  x * x
end

puts square 809.312809
puts square 7892.809321
puts square 1890321.980321
```

$7.$ What does the following error message mean?

```
SyntaxError: (irb):2: syntax error, unexpected ')', expecting '}'
  from /usr/local/rvm/rubies/ruby-2.5.3/bin/irb:16:in `<main>'
```

$A:$

There's a `}` where a `)` was expected.
