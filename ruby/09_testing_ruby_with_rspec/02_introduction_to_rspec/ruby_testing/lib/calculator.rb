# frozen_string_literal: true

# Calculator
class Calculator
  def add(*numbers)
    numbers.reduce(0) { |sum, curr| sum + curr }
  end

  def multiply *numbers
    numbers.reduce(1) { |prod, curr| prod * curr }
  end
end
