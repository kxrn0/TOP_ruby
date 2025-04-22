def decompose(number)
  places = []

  while number > 0
    place = number % 10

    places.push place

    number /= 10
  end

  places
end

places = decompose 14215

puts places
