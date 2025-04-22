def factorial(number)
  result = 1

  (number + 1).times do |i|
    result *= i unless i === 0
  end

  result
end

(5..8).each { |n| puts factorial n }
