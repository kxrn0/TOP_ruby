$1.$ Write a program that checks if the sequence of characters "lab" exists in the following strings. If it does exist, print out the word.

- "laboratory"
- "experiment"
- "Pans Labyrinth"
- "elaborate"
- "polar bear"

$A:$

```ruby
words = [
  "laboratory",
  "experiment",
  "Pans Labyrinth",
  "elaborate",
  "polar bear",
]
reg = /lab/i

words.each do |word|
  if reg.match word
    puts word
  end
end
```

$2.$ What will the following program print to the screen? What will it return?

```ruby
def execute(&block)
  block
end

execute { puts "Hello from inside the execute method!" }
```

$A:$

It doesn't call the block, so it won't print anything, but it will return the passed block.

$3.$ What is exception handling, and what problems does it solve?

$A:$

Exception handling is guarding againts situations that would otherwise crash the program.

$4.$ Modify the code in exercise 2 to make the block execute properly.

$A:$

```ruby
def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!" }
```

$5.$ Why does the following code

```ruby
def execute(block)
  block.call
end

execute { puts "Hello from inside the execute method!" }
```

give us the following error when we run it?

```
block.rb1:in `execute': wrong number of arguments (0 for 1) (ArgumentError)
from test.rb:5:in `<main>'
```

$A:$

The method expects a parameter that is not a naked block, but we give it one anyway. The block should be wrapped into a proc like this

```ruby
def execute(block)
  block.call
end

execute Proc.new { puts "Hello from inside the execute method!" }
```