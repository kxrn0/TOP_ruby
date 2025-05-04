$1.$ Create a Dog class that is initialized with a name

$A:$

```ruby
class Dog
  def initialize name
    @name = name
  end
end
```

$2.$ Create a new instance of the Dog class.
$A:$

```ruby
class Dog
  def initialize name
    @name = name
  end
end

god = Dog.new "god"
```

$3.$ Add a bark() instance method to the Dog class that returns "Ruff ruff".

$A:$

```ruby
class Dog
  def initialize name
    @name = name
  end

  def bark
    "Ruff ruff"
  end
end
```

$4.$ Create an instance of the Dog class, and then call the bark() method.
$A:$

```ruby
class Dog
  def initialize name
    @name = name
  end
end

god = Dog.new "god"

god.bark
```

$5.$

```ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
end
```

What does the following code return?

```ruby
bob = Person.new("Bob", 22)
bob.speak()
```

$A:$

It throws an error, as there's no `speak` method in the `Person` class.

$6.$

```ruby
class Insect
  def initialize(age_in_days)
    @age_in_days = age_in_days
  end
end
```

Add an instance method to the Insect class to calculate the age_in_years.

$A:$

```ruby
class Insect
  DAYS_IN_YEAR = 365

  def initialize(age_in_days)
    @age_in_days = age_in_days
  end

  def age_in_years
    (@age_in_days / DAYS_IN_YEAR).to_i # in case the parameter to `initialize` is a float
  end
end
```

$7.$

```ruby
class Dog
  def speak()
    return("woof woof")
  end
end
```

What does the following code return?

```ruby
Dog.speak
```

$A:$
It throws an error, we can't call an instance method from the class itself.

$8.$ Create a Lamp class with a class method called about_me that returns the string "We brighten up people's lives".

$A:$

```ruby
class Lamp
  def about_me
    "We brighten up people's lives"
  end
end
```

$9.$

```ruby
class WaterBottle
  def initialize(size)
    @size = size
  end
end
```

Add a method to the WaterBottle class that returns the size of the WaterBottle, and demonstrate how this method can be used.

$A:$

```ruby
class WaterBottle
  attr_reader :size

  def initialize(size)
    @size = size
  end

end

bottle = WaterBottle.new 100

puts bottle.size
```

$10.$ Create a Person class that is initialized with an age, and create an @age=() method that can be used to update the @age instance variable. Also include an age method that returns the value of the @age instance variable. Demonstrate how the methods can be used.

$A:$

```ruby
class Person
  attr_accessor :age

  def initialize age
    @age = age
  end
end

person = Person.new 100

puts person.age

person.age = 101

puts person.age
```

$11.$ Modules define methods that can be added to classes. Modules are useful for organizing code, and for code that can be reused in multiple classes. Unlike classes, modules can't be instantiated.

```ruby
module Clueless
  def funny()
    return("AS IF?!")
  end
end

class Actress
  include Clueless
end
```

What does this code return?

```ruby
alicia = Actress.new
alicia.funny()
```

$A:$

`"AS IF?!"`

$12.$

```ruby
module HappyHappy
  def say_something()
    return("Happy happy, joy joy")
  end
end

class Person
  include HappyHappy
end

class Alien
  include HappyHappy
end
```

Demonstrate that instances of the Person class, and instances of the Alien class use the say_something method.
$A:$

```ruby
module HappyHappy
  def say_something()
    return("Happy happy, joy joy")
  end
end

class Person
  include HappyHappy
end

class Alien
  include HappyHappy
end

person = Person.new
alien = Alien.new

puts person.say_something
puts alien.say_something
```

$13.$ Create a module called MathHelper with a method multiply_by_two that takes a number as an argument and multiplies it by two. Create a class Homework and demonstrate how multiply_by_two can be used.

$A:$

```ruby
module MathHelper
  def multiply_by_two number
    number * 2
  end
end

class Homework
  include MathHelper
end

solver = Homework.new

puts solver.multiply_by_two 3
```

$14.$ Inheritance is a way for classes to access all the methods from a parent class. Inheritance is a great way for a class to get all the methods from a parent class and add some extra ones. In the following example, the Dog class inherits from the Mammal class.

```ruby
class Mammal
  def heartbeat?
    true
  end
end

class Dog < Mammal
end
```

Demonstrate that instances of the Dog class have access to the hearbeat? method.

$A:$

```ruby
class Mammal
  def heartbeat?
    true
  end
end

class Dog < Mammal
end

dog = Dog.new

puts god.heartbeat?
```

$15.$ The ancestors() class method demonstrate all the classes that a class inherits from. Show all the classes that the Array class inherits from.

$A:$

```
[Array, Enumerable, Object, PP::ObjectMixin, Kernel, BasicObject]
```

$16.$

```ruby
class Box
end

my_box = Box.new
```

Explain how my_box.methods().count() returns a number greater than 50, even though no methods are defined in the Box class.

$A:$

All classes created with `class` have the ancestors

```
<new class> => Object => PP::ObjectMixin => Kernel => BasicObject
```

and by extension have access to all the methods its ancestors have, which add up to over 50.

$17.$ Create a BaseballPlayer class that is initialized with hits, walks, and at_bats. Add a batting_average() method that returns hits divided by at_bats as a floating point number. Add an on_base_percentage() that returns (hits + walks) divided by at_bats as a floating point number. Demonstrate how the batting_average() and base_percentage() methods can be used.

$A:$

```ruby
class BaseballPlayer
  def initialize hits, walks, at_bats
    @hits = hits
    @walks = walks
    @at_bats = at_bats
  end

  def batting_average
    @hits / @at_bats.to_f
  end

  def on_base_percentage
    (@hits + @walks) / @at_bats.to_f
  end
end

player = BaseballPlayer.new 100, 200, 300

puts player.batting_average

puts player.on_base_percentage
```

$18.$ Create a Person class that is initialized with a first_name and a last_name. Create first_name() and last_name() methods that return the corresponding instance variables. Create a full_name method that concatenates the first_name and last_name in a single string.

$A:$

```ruby
class Person
  attr_reader :first_name, :last_name

  def initialize first_name, last_name
    @first_name = first_name
    @last_name = last_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

person = Person.new "Richard", "Stallman"

puts person.full_name
```

$19.$ Create a module called MathHelpers with the exponent() method that takes two numbers as arguments, and raises the first number to the power of the second number. Create a class called Calculator with a method called square_root() that takes the square root of the number. The square_root() method should use the exponent() method.

$A:$

```ruby
module MathHelpers
  def exponent a, b
    a ** b
  end
end

class Calculator
  include MathHelpers

  def square_root x
    exponent x, 0.5
  end
end

calc = Calculator.new

puts calc.square_root 16
```
