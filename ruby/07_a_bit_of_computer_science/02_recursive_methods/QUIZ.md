### $1.-$ Define a recursive function that finds the factorial of a number.

$A:$

```ruby
def factorial number
  return 1 if number <= 0

  number * factorial number - 1
end
```

### $2.-$ Define a recursive function that returns `true` if a string is a palindrome, and `false` otherwise.

$A:$

A palindrome is a string that reads the same both ways, for example the string "abcdcba", or "abccba". Is a zero length string palindromic? It does read the same both ways, and a one length string does so as well, so I'll go with yes. I can check if the first and last characters are the same, remove them from the string, and ask if the same applies to the resulting string;

```
abcdcba => a == a
bcdcb => b == b
cdc => c == c
d == d

abccba => a == a
bccb => b == b
cc => c == c
''
```

Thus, if the length of the string is less or equal to one, it is palindromic.

The `[]` operator can be used on strings to get a slice. The codumentation says that

```
string[range] → new_string or nil
```

```ruby
def palindrome?(string)
  return true if string.size <= 1

  first = string[0]
  last = string[-1]

  return false if first != last

  palindrome? string[1..-2]
end
```

### $3.-$ Define a recursive function that takes an argument n and prints `'n bottles of beer on the wall'`, `'(n - 1) bottles of beer on the wall'`, ... `'no more bottles of beer on the wall'`.

$A:$

```ruby
def bottle_song(bottles)
  return puts 'no more bottles of beer on the wall' if bottles <= 0

  quantifier = bottles == 1 ? '' : 's'

  puts "#{bottles} bottle#{quantifier} of beer on the wall"

  bottle_song bottles - 1
end
```

### $4.-$ Define a recursive function that takes an argument n, and returns the fibonacci value of that position. The fibonacci sequence is 0, 1, 1, 2, 3, 5, 8, 13, 21... So fib(5) should return 5 and fib(6) should return 8.

$A:$

```ruby
def fibonacci(position)
  raise "number can't be negative" if position.negative?

  if position.zero?
    0
  elsif position == 1
    1
  else
    fibonacci(position - 1) + fibonacci(position - 2)
  end
end
```

### $5.-$ Define a recursive function that flattens an array. The method should convert [[1, 2], [3, 4]] to [1, 2, 3, 4] and [[1, [8, 9]], [3, 4]] to [1, 8, 9, 3, 4].

$A:$

```ruby
def flatten(value, flat = [])
  if value.is_a? Array
    value.each do |item|
      flatten item, flat
    end
  else
    flat.push value
  end

  flat
end
```

### $6.-$ Use the roman_mapping hash to define a recursive method that converts an integer to a Roman numeral.

$A:$

You can list the elements in a hash in the order they were added with `each`.

I think the solution will involve iterating the hash until we find a value that is less than or equal to the current number.

Say you have the number 127. That's CXXVII in roman. So we iterate from M, CM, ..., C. C == 100 <= 127. Thus, we know C is in there, and we subtract 100 from our number, leaving us with 27.

The next iteration leads us to X, so the number is CX..., and we subtract X == 10 from 27 leaving us with 17, and so on.

```ruby
ROMAN_MAPPING = {
  1000 => 'M',
  900 => 'CM',
  500 => 'D',
  400 => 'CD',
  100 => 'C',
  90 => 'XC',
  50 => 'L',
  40 => 'XL',
  10 => 'X',
  9 => 'IX',
  5 => 'V',
  4 => 'IV',
  1 => 'I'
}.freeze

def find_less_or_equal(number)
  ROMAN_MAPPING.each do |decimal, roman|
    return [decimal, roman] if number >= decimal
  end
end

def decimal_to_roman(decimal, roman = [])
  return if decimal <= 0

  loe = find_less_or_equal decimal

  roman.push loe[1]

  decimal_to_roman(decimal - loe[0], roman)

  roman.join
end
```

### $7.-$ Use the roman_mapping hash to define a recursive method that converts a Roman numeral to an integer.

$A:$

It will likely be similar to the solution above where we loop through the elements of the hash, find the first for which some condition is true, remove the pattern from the roman numeral, add the value to the decimal variable, and continue doing so until the roman string is empty.

```ruby
ROMAN_MAPPING = {
  'M' => 1000,
  'CM' => 900,
  'D' => 500,
  'CD' => 400,
  'C' => 100,
  'XC' => 90,
  'L' => 50,
  'XL' => 40,
  'X' => 10,
  'IX' => 9,
  'V' => 5,
  'IV' => 4,
  'I' => 1
}.freeze

def find_match(number)
  ROMAN_MAPPING.each do |roman, decimal|
    size = roman.size
    slice = number[0...size]

    return [size, decimal] if slice == roman
  end
end

def roman_to_decimal(roman, decimal = [])
  return if roman == ''

  match = find_match roman

  decimal.push match[1]

  roman_to_decimal roman[match[0]..], decimal

  decimal.reduce(0) { |total, current| total + current }
end
```
