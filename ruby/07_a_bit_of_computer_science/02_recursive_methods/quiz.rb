=begin
  1.- Define a recursive function that finds the factorial of a number.
=end

def factorial(n)
  return 1 if n <= 1

  n * factorial(n - 1)
end

=begin
  2.- Define a recursive function that returns true if a string is a palindrome and false otherwise.
=end

def check_if_str_is_palindrome(string)
  return true if !string || string.size == 1

  return false if string[0] != string[-1]

  return check_if_str_is_palindrome string[1, string.size - 2]
end

=begin
  3.- Define a recursive function that takes an argument n and prints "n bottles of beer on the wall", "(n-1) bottles of beer on the wall", ..., "no more bottles of beer on the wall".
=end

def count_bottles(n)
  if n <= 0
    puts "no more bottles of beer on the wall"
  else
    puts "#{n} bottle#{n == 1 ? "" : "s"} of beer on the wall"
    count_bottles n - 1
  end
end

=begin
  4.- Define a recursive function that takes an argument n and returns the fibonacci value of that position. The fibonacci sequence is 0, 1, 1, 2, 3, 5, 8, 13, 21... So fib(5) should return 5 and fib(6) should return 8.
=end

def fibonacci(n)
  if n == 0
    return 0
  elsif n <= 2
    return 1
  else
    return fibonacci(n - 1) + fibonacci(n - 2)
  end
end

=begin
  5.- Define a recursive function that flattens an array. The method should convert [[1, 2], [3, 4]] to [1, 2, 3, 4] and [[1, [8, 9]], [3, 4]] to [1, 8, 9, 3, 4].
=end

def flatten(array, flat = [])
  array.each do |element|
    if element.class == Array
      flatten(element, flat)
    else
      flat.push element
    end
  end

  flat
end

=begin
  Use the roman_mapping hash to define a recursive method that converts an integer to a Roman numeral.
=end

$roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I",
}

def i_to_r(number, chars = [])
  return if number <= 0

  roman = { key: nil, value: nil }

  $roman_mapping.each do |key, value|
    if number >= key
      roman[:key] = key
      roman[:value] = value
      break
    end
  end

  number -= roman[:key]
  chars.push roman[:value]

  r_to_i number, chars

  chars.join ""
end

=begin
  Use the roman_mapping hash to define a recursive method that converts a Roman numeral to an integer. 
=end

$mapping_roman = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1,
}

def r_to_i(roman, number = 0)
  return number if roman == ""

  try = roman[0, 2]
  value = $mapping_roman[try]

  unless value
    try = roman[0, 1]
    value = $mapping_roman[try]
  end

  number += value
  roman = roman[try.size, roman.size]

  r_to_i roman, number
end
