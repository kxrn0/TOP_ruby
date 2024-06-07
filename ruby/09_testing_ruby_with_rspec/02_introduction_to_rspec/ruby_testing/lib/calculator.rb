class Calculator
  def add *numbers
    numbers.reduce(0) { |total, current| total + current }
  end

  def multiply *numbers
    numbers.reduce(1) { |total, current| total * current }
  end

  def substract a, b
    a - b
  end
end
