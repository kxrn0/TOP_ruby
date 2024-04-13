=begin
  1.- Add a class method to your MyCar class that calculates the gas mileage (i.e. miles per gallon) of any car.

  class MyCar
    # rest of the fucking...
    
    def self.mileage miles, gallons
      miles / gallons
    end
  end
=end

=begin
  2.- Override the to_s method to create a user friendly print out of your object.

  class MyObj
    attr_reader :color, :volume, :density

    def initialize color, volume, density
      @color = color
      @volume = volume
      @density = density
    end

    def to_s
      "color: #{color}, volume: #{volume}, density: #{density}"
    end
  end

  myCar = MyObj.new "red", 10, 100

  puts myCar
=end

=begin
  3.- When running the following code...

  class Person
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  bob = Person.new("Steve")
  bob.name = "Bob"

  We get the following error...

  test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

  Why do we get this error, and how do we fix it?

  We get the error because we don't specify a setter for the @name property, only a getter. To fix it we have to change `attr_reader :name` to `attr_accessor :name`
=end
