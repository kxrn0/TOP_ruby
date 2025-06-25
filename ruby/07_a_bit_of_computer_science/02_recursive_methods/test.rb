# frozen_string_literal: true

# def factorial(number)
#   return 1 if number <= 0

#   number * factorial(number - 1)
# end

# 10.times do |n|
#   puts "#{n}!: #{factorial n}"
# end

# =====================================

# def palindrome?(string)
#   return true if string.size <= 1

#   first = string[0]
#   last = string[-1]

#   return false if first != last

#   palindrome? string[1..-2]
# end

# puts palindrome? 'abcdcba'
# puts palindrome? 'abccba'
# puts palindrome? 'string'

# =====================================

# def bottle_song(bottles)
#   return puts 'no more bottles of beer on the wall' if bottles <= 0

#   quantifier = bottles == 1 ? '' : 's'

#   puts "#{bottles} bottle#{quantifier} of beer on the wall"

#   bottle_song bottles - 1
# end

# bottle_song 10

# =====================================

# def fibonacci(position)
#   raise "number can't be negative" if position.negative?

#   if position.zero?
#     0
#   elsif position == 1
#     1
#   else
#     fibonacci(position - 1) + fibonacci(position - 2)
#   end
# end

# 10.times do |n|
#   puts "#{n}: #{fibonacci n}"
# end

# =====================================

# def flatten(value, flat = [])
#   if value.is_a? Array
#     value.each do |item|
#       flatten item, flat
#     end
#   else
#     flat.push value
#   end

#   flat
# end

# p flatten [[1, 2], [3, 4]]
# p flatten [[1, [8, 9]], [3, 4]]

# =====================================

# ROMAN_MAPPING = {
#   1000 => 'M',
#   900 => 'CM',
#   500 => 'D',
#   400 => 'CD',
#   100 => 'C',
#   90 => 'XC',
#   50 => 'L',
#   40 => 'XL',
#   10 => 'X',
#   9 => 'IX',
#   5 => 'V',
#   4 => 'IV',
#   1 => 'I'
# }.freeze

# def find_less_or_equal(number)
#   ROMAN_MAPPING.each do |decimal, roman|
#     return [decimal, roman] if number >= decimal
#   end
# end

# def decimal_to_roman(decimal, roman = [])
#   return if decimal <= 0

#   loe = find_less_or_equal decimal

#   roman.push loe[1]

#   decimal_to_roman(decimal - loe[0], roman)

#   roman.join
# end

# puts decimal_to_roman 127
# puts decimal_to_roman 999
# puts decimal_to_roman 429
# puts decimal_to_roman 12
# puts decimal_to_roman 3
# puts decimal_to_roman 1
# puts decimal_to_roman 0

# =====================================

ROMAN_MAPPING = {
  'M' => 1000,
  'CM' => 900,
  'D' => 500,
  'CD' => 400,
  'C' => 100,
  'XC' => 90,
  'L' => 50,
  'XL' => 40,
  'X' => 10,
  'IX' => 9,
  'V' => 5,
  'IV' => 4,
  'I' => 1
}.freeze

def find_match(number)
  ROMAN_MAPPING.each do |roman, decimal|
    size = roman.size
    slice = number[0...size]

    return [size, decimal] if slice == roman
  end
end

def roman_to_decimal(roman, decimal = [])
  return if roman == ''

  match = find_match roman

  decimal.push match[1]

  roman_to_decimal roman[match[0]..], decimal

  decimal.reduce(0) { |total, current| total + current }
end

puts roman_to_decimal 'CXXVII'
puts roman_to_decimal 'CMXCIX'
puts roman_to_decimal 'CDXXIX'
puts roman_to_decimal 'XII'
puts roman_to_decimal 'III'
puts roman_to_decimal 'I'
