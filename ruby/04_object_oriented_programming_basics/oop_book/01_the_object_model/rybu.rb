=begin
  1.- How do we create an object in ruby? Give an example of the creation of an object.

  Special objects like numbers or strings can be created with literal notation like `n = 5`.
  Custom objects are created by calling the `new` method on the class, followed by any parameters the constructor may expect.

  Example:

  ```
  class Entity
  end

  my_object = Entity.new
  ```
=end

=begin
  2.- What is a module? What is it's purpose? How do we use them with our classes? Create a class module for the class you created in exercise 1 and include it properly.

  A module is a set of methods. The purpose of the module is to make it easier to include the same behaviour in several classes without having to write it from scratch every time.

  Example:

  module MyMath
    def sum a, b
      a + b
    end

    def multiply a, b
      a * b
    end
  end

  class Entity
    include MyMath
  end
=end
