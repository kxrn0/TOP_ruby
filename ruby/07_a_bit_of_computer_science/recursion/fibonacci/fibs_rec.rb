# frozen_string_literal: true

def fibs_rec_helper(position, fibs)
  fib = fibs[position]

  if fib.nil?
    fib = fibs_rec_helper(position - 1, fibs) + fibs_rec_helper(position - 2, fibs)

    fibs.push fib
  end

  fib
end

def fibs_rec(position)
  raise "position can't be negative" if position.negative?

  if position <= 1
    return [0] if position.zero?

    return [0, 1]
  end

  fibs = [0, 1]

  fibs_rec_helper position - 1, fibs

  fibs
end

numbers = fibs_rec 100

puts numbers
