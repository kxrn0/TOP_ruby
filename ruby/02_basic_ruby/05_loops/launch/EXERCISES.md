$1.$ What does the `each` method in the following program return after it's finished executing?

```ruby
x = [1, 2, 3, 4, 5]
x.each do |a|
  a + 1
end
```

$A:$

It returns the array `x`.

$2.$ Write a while loop that takes input from the user, performs an action, and only stops when the user types "STOP". Each loop can get info from the user.
$A:$

```ruby
input = ""
until input == "STOP"
  print "Enter something, enter 'STOP' to stop > "

  input = gets.chomp

  puts "You entered: #{input}"
end
```

$3.$ Write a method that counts down to zero using recursion.

$A:$

```ruby
def count_down number
  if number >= 0
    puts number

    count_down number - 1
  end
end
```
