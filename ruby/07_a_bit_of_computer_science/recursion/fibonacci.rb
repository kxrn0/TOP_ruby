def fibonacci n
  last  = 0
  current = 1
  fibs = []

  n.times do
    fibs.push last

    temp = current
    current += last
    last = temp
  end
  fibs
end

def fun n, fibs = [0, 1]
  return if n <= 0

  fibs.push fibs[-1] + fibs[-2]

  fun n - 1, fibs

  return fibs
end

puts fun 200