$1.$ Write a program called `name.rb` that asks the user to type in their name and then prints out a greeting message with their name included.

$A:$

```ruby
def greet
  name = gets.chomp

  puts "hi #{name}"
end

greet
```

$2.$ Write a program called `age.rb` that asks the user how old they are and then tells them how old they will be in 10, 20, 30, and 40 years.

$A:$

```ruby
def age
  puts "How old are you?"

  age = gets.chomp.to_i

  (1..4).each do |n|
    time  = n * 10
    puts "In #{time} years you will be:\n#{age + time}"
  end
end

age
```

$3.$ Add another section onto `name.rb` that prints the name of the user ten times. You must do this without explicitly writting the `puts` method ten times in a row.

```ruby
def greet
  name = gets.chomp

  puts "hi #{name}"

  10.times do
    puts name
  end

  puts "Segmentation fault. Core dumped"
end

greet
```

$4.$ Modify `name.rb` again so that it first asks the user for their first name, saves it to a variable, and then does the same for the last name. The output is their full name all at once.

$A:$

```ruby
def greet
  print "Enter your first name: "
  first = gets.chomp
  print "Enter your last name: "
  last = gets.chomp

  puts "hi #{first} #{last}"
end

greet
```

$5.$ Loot at the following programs

```ruby
x = 0
3.times do
  x += 1
end
puts x
```

and

```ruby
y = 0
3.times do
  y += 1
  x = y
end
puts x
```

What does `x` print to the screen in each case? Do they both give errors? Are the errors different? Why?

$A:$
The first program prints 3 without errors. The second one prints the error

```
undefined local variable or method `x' for main (NameError)

puts x
     ^
```

because `x` is out of scope.
