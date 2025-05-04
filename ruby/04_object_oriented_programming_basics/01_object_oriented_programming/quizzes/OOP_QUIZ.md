$1.$ What is the value of the variable `x`?

```ruby
x = String.new("i wish i was surfing")
```

$A:$

The string "i wish i was surfing".

$2.$ Make the following object: `"i thought he said this wasn't going to be abstract..."`.

$A:$

```ruby
obj = "i thought he said this wasn't going to be abstract..."
```

$3.$ What does this return?

```ruby
"hi".methods()
```

$A:$

Probably a list of methods available to all string instances. Running it we get a large array with just that, some of the methods are

```
[:encoding,
 :force_encoding,
 :slice,
 :valid_encoding?,
 :ascii_only?,
 :unicode_normalize!,
 :unicode_normalized?,
 :b,
 :dup,
 :shellsplit,
 :to_r,
 :unicode_normalize,
 :encode,
 :encode!,
]
```

but there seem to be hundreds, if not thousands of them.

$4.$ What does this return?

```ruby
"hello".upcase()
```

$A:$
`"HELLO"`

$5.$ What does this return?

```ruby
"sUp DuDe".swapcase()
```

$A:$

`"SuP dUdE"`

$6.$ What does this return?

```ruby
"This is a sentence, kinda".split()
```

$A:$

`["This", "is", "a", "sentence,", "kinda"]`

$7.$ What is the syntax for calling methods on strings objects?

$A:$

`<string>.<method>[...<params>]`

$8.$ Create a string object with the text "road trip".

$A:$

```ruby
str = "road trip"
```

$9.$ What does this code return?

```ruby
Array.new()
```

$A:$

A new array;

```
[]
```

$10.$ What does this code print?

```ruby
my_array = Array.new()
my_array.push("nice")
my_array.push("hair")
puts my_array.inspect
```

$A:$

```
["nice", "hair"]
```

$11.$ What is a class?

$A:$

A blueprint for objects. A class defines the variables and objects an instance object will be initialized with. It has a `initialize` constructor that can take parameters to set the instance variables to.

$12.$ What is an object?

$A:$

An instance of a class.

$13.$ How is a String object created?

$A:$

It can be created with the literal syntax

```ruby
str = "string"
```

or with the object syntax

```ruby
str = String.new "string"
```

$14.$ Create a new Hash object

$A:$

```ruby
empty_hash = {}
```

$15.$ Create a new Array object, and add two string objects to it: "fun" and "games".

$A:$

```ruby
array = ["fun", "games"]
```

$16.$ What does the following code evaluate to?

```ruby
my_string = String.new("special")
my_string.push("cool")
```

$A:$

An error because there's no `push` method in string objects.

$17.$ What does the following code evaluate to?

```ruby
a_string = String.new("ear")
a_string.class()
```

$A:$

The class `String`.

$18.$ What does the following code evaluate to?

```ruby
an_array = Array.new()
an_array.class()
```

$A:$

The class `Array`.

$19.$ This code creates an Animal class

```ruby
class Animal
end
```

Create an instance of the Animal class, and assign it to the variable fido.

$A:$

```ruby
class Animal
end

fido = Animal.new
```

$20.$ This class is used to create a Dog class with a speak() method.

```ruby
class Dog
  def speak
    "ruff ruff"
  end
end
```

Create an instance of the Dog class, and assign it to the variable spot. Then call the speak() method on the dog spot.

$A:$

```ruby
class Dog
  def speak
    "ruff ruff"
  end
end

spot = Dog.new

spot.speak
```

$21.$ Define a Penguin class method with a looks() method that returns "We are cute!"

$A:$

```ruby
class Penguin
  def looks
    "We are cute!"
  end
end
```

$22.$ The following code creates a Fish class with a general_overview() class method.

```ruby
class Fish
  def self.general_overview()
    return("Fish are animals that live in the sea")
  end
end
```

Call the general_overview() method on the Fish class.

```ruby
class Fish
  def self.general_overview()
    return("Fish are animals that live in the sea")
  end
end

Fish.general_overview
```

$23.$ Define a calculator class with an add() class method. Demonstrate how the add() class method can be called to add two numbers.

$A:$

```ruby
class Calculator
  def self.add a, b
    a + b
  end
end

sum = Calculator.add 1, 2
```

$24.$ Here's how to define a Person class that is instantiated with a name.

```ruby
class Person
  def initialize(name)
    @name = name
  end
end
```

Identify the key components of this code.

$A:$
The key components are the class declaration, the initialize method, and the assignment of the instance variable to the constructor parameter.

$25.$ Here's how to create a Person object with the name "Fred".

```ruby
class Person
  def initialize(name)
    @name = name
  end
end

my_person_object = Person.new("Fred")
```

Explain how the my_person_object was instantiated.

$A:$

When the `Person.new` method was called, the string `"Fred"` was passed to the `initialize` constructor, which set the value of the `@name` instance variable to the given string.

$26.$ Here's how to create a Lion class with a name instance variable and a method that returns the name.

```ruby
class Lion
  def initialize(name)
    @name = name
  end

  def return_lions_name
    return(@name)
  end
end

simba = Lion.new("Simba")
puts simba.return_lions_name() # prints "Simba"
```

Explain how the return_lions_name method works.

$A:$

It returns the value of the `@name` variable of the instance object.

$27.$ Create a Celsius class that is initialized with temperature.

$A:$

```ruby
class Celsius
  def initialize temperature
    @temperature = temperature
  end
end
```

$28.$ Add a method to_farenheit to the Celsius class that convers the celsius temperature to farenheit.

$A:$

```ruby
class Celsius
  def initialize temperature
    @temperature = temperature
  end

  def to_farenheit
    @temperature * 1.8 + 32
  end
end
```
