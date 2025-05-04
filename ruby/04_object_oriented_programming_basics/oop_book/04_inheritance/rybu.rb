=begin
  1.- Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information about the vehicle that makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass that also has a constant defined that separates it from the MyCar class in some way.

  class Vehicle
    def initialize color, year, model
      @color = color
      @year = year
      @model = model
    end
  end

  class Car < Vehicle
    GRADING = "T23"

    def initialize color, year, model
      super color, year, model
    end
  end

  class Truck
    RISK_OF_HEAVY_METAL_POISONING = true

    def initialize color, year, model
      super color, year, model
    end
  end
=end

=begin
  2.- Add a class variable to your superclass that can keep track of the number of objects created that inherit from the superclass. Create a method to print out the value of this class variable as well.

  class Vehicle
    @@vehicles = 0

    def initialize color, year, model
      # rest of the fucking...
      
      @@vehicles += 1
    end

    def self.vehicles
      @@vehicles
    end
  end
=end

=begin
  3.- Create a module that you can mix into one of your subclasses that describes the behaviour unique to that subclass.

  module Unique
    def unique_thing n
      n + 1
    end
  end

  class Car
    include Unique

    # rest of the fucking...
  end
=end

=begin
  4.- Print to the screen your method lookup for the classes that you have created.

  Car -> Unique -> Vehicle -> Rest of the fucking...
=end

=begin
  5.- Move all of the methods from the MyCar class that also pertain to the MyTruck class into the Vehicle class. Make sure that all of your previous method calls are working when you are finished.

  class Vehicle
    @@vehicles = 0

    attr_reader :year, :model, :miles
    attr_accessor :color

    def initialize color, year, model
      @color = color
      @year = year
      @model = model
      @miles = 0
      @@vehicles += 1
    end
  
    def drive miles
      @miles += miles
    end

    def self.vehicles
      @@vehicles
    end
  end

  class Car < Vehicle
    def initialize color, year, model, seats
      super color, year, model
      @seats = seats
    end
  end

  class Truck
    def initialize color, year, model, capacity
      super color, year, model
      @capacity = capacity
    end
  end
=end

=begin
  6.- Write a method called age that calls a private method to calculate the age of the vehicle. Make sure the private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help.

  class Vehicle
    attr_reader :year

    def initialize year
      @year = year
    end

    def age
      compute_age
    end

    private

    def compute_age
      Time.now.year - year
    end
  end
=end

=begin
  7.- Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...

  puts "Well done!" if joe.better_grade_than?(bob)

  class Student
    attr_reader :name

    def initialize name, grade
      @name = name
      @grade = grade
    end

    def better_grade_than? other
      @grade > other.grade
    end

    protected

    attr_reader :grade
  end
=end

=begin
  8.- Given the code

  bob = Person.new
  bob.hi

  and the error NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

What is the problem and how would you go about fixing it?

We can't access the private method `hi` of the object. It should be made public if we want to access it.
=end
