$1.$ Write down whether the following expressions return `true` or `false`. Then type the expression into irb to see the results.

```ruby
(32 * 4) >= 129
false != !true
true == 4
false == (847 == '847')
(!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false
```

$A:$

```ruby
(32 * 4) >= 129  # false
false != !true  # false
true == 4  # false
false == (847 == '847')  # true
(!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false  # true
```

$2.$ Write a method that takes a string as an argument. The method shold return a new, all caps version of the string, only if the string is longer than 10 characters.

$A:$

```ruby
def solution(str)
  if str.size <= 10
    str
  else
    str.upcase
  end
end
```

$3.$ Write a program that takes a number from the user between 0 and 100 and reports back whether the number is between 0 and 50, 51 and 100, or above 100.

$A:$

```ruby
def solution
  print "Enter a number > ";
  number = gets.chomp.to_i

  if number.between? 0, 50
    puts "The number is between 0 and 50."
  elsif number.between? 51, 100
    puts "The number is between 51 and 100."
  elsif number > 100
    puts "The number is above 100."
  else
    puts "The number is negative or it doesn't exist."
  end
end
```

$4.$ What will each block of code below print to the screen?

```ruby
'4' == 4 ? puts("TRUE") : puts("FALSE")
```

```ruby
x = 2
if ((x * 3) / 2) == (4 + 4 - x - 3)
  puts "Did you get it right?"
else
  puts "Did you?"
end
```

```ruby
y = 9
x = 10
if (x + 1) <= (y)
  puts "Alright."
elsif (x + 1) >= (y)
  puts "Alright now!"
elsif (y + 1) == x
  puts "ALRIGHT NOW!"
else
  puts "Alrighty!"
end
```

$A:$

```ruby
'4' == 4 ? puts("TRUE") : puts("FALSE")  # FALSE
```

```ruby
x = 2
if ((x * 3) / 2) == (4 + 4 - x - 3)
  puts "Did you get it right?"
else
  puts "Did you?"
end

# Did you get it right?
```

```ruby
y = 9
x = 10
if (x + 1) <= (y)
  puts "Alright."
elsif (x + 1) >= (y)
  puts "Alright now!"
elsif (y + 1) == x
  puts "ALRIGHT NOW!"
else
  puts "Alrighty!"
end

# Alright now!
```

$5.$ When you run the following code

```ruby
def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope"
end

equal_to_four(5)
```

You get the following error message

```
syntax error, unexpected end-of-input, expecting keyword_end
```

Where do you get this error, and how can you fix it?

$A:$

The error occurs because there's no `end` to the `if-else` chain. The correct code is

```ruby
def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope"
  end
end

equal_to_four(5)
```

$6.$ Write down whether the following expressions return `true` or `false` or raise an error. Then, type the expressions into irb to see the results.

```ruby
(32 * 4) >= "129"
847 == '847'
'847' < '846'
'847' > '846'
'847' > '8478'
'847' < '8478'
```

$A:$

guess

```ruby
(32 * 4) >= "129"  # false
847 == '847'  # false
'847' < '846'  # false
'847' > '846'  # true
'847' > '8478'  # false
'847' < '8478'  # true
```

actual

```ruby
(32 * 4) >= "129"  # error
847 == '847'  # false
'847' < '846'  # false
'847' > '846'  # true
'847' > '8478'  # false
'847' < '8478'  # true
```
