# frozen_string_literal: true

def fibs_helper(position)
  numbers = [0, 1]

  position.times do |index|
    next if index <= 1

    numbers.push numbers[index - 1] + numbers[index - 2]
  end

  numbers
end

def fibs(position)
  raise "position can't be negative!" if position.negative?

  if position <= 1
    return [0] if position.zero?

    return [0, 1]
  end

  fibs_helper position
end

numbers = fibs 100

puts numbers
