# frozen-string-literal: true

# The methods of this module are to be private
module Privatizable
  private

  def square(number)
    number**2
  end
end

# Test class
class Klass
  include Privatizable

  def sum_of_squares(first, second)
    (square first) + (square second)
  end
end

instance = Klass.new

puts instance.sum_of_squares 2, 3

puts instance.square 3
