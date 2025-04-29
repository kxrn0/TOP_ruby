$1.$ Write a program that writes a greeting message. This program should contain a method called `greeting` that takes a `name` as its parameter and returns a string.

$A:$

```ruby
def greeting name
  "hi #{name}"
end

print "Enter your name > "
name = gets.chomp
puts greeting name
```

$2.$ What do the following expressions evaluate to?

```
1. x = 2

2. puts x = 2

3. p name = "Joe"

4. four = "four"

5. print something = "nothing"
```

$A:$

```ruby
x = 2 # 2

puts x = 2  # nil

p name = "Joe"  # "Joe"

four = "four" # "four"

print something = "nothing" # nil
```

$3.$ Write a program that includes a method called `multiply` that takes two arguments and returns the product of the two numbers.

$A:$

```ruby
def multiply a, b
  a * b
end
```

$4.$ What will the following code print to the screen?

```ruby
def scream(words)
  words = words + "!!!!"
  return
  puts words
end

scream("Yippeee")
```

$A:$

Nothing since the method returns before reaching the `puts` statement.

$5.$

1. Edit the method definition in exercise #4 so that it does print words on the screen.
2. What does it return now?

$A:$

1.

```ruby
def screan words
  words += "!!!!"

  puts words

  words
end
```

2. I made it return the argument concatenated with the string `"!!!!"`.


$6.$ What does this error message tell you?
```
ArgumentError: wrong number of arguments (1 for 2)
  from (irb):1:in `calculate_product'
  from (irb):4
  from /Users/username/.rvm/rubies/ruby-2.5.3/bin/irb:12:in `<main>'
```

$A:$

The method `calculate_product` was called with the wrong number of arguments. It expected two, but was only given one. The second parameter doesn't set a default argument, otherwise it wouldn't have thrown an error.