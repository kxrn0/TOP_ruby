# frozen_string_literal: true

def reorder(char, shift)
  length = 26
  ascii_shift = char == char.upcase ? 65 : 97
  order = char.ord - ascii_shift
  reordered = (order + shift) % length

  (reordered + ascii_shift).chr
end

def cipher(string, shift)
  chars = string.chars
  ciphered = chars.map do |char|
    next char unless char.match?(/[a-z]/i)

    reorder char, shift
  end

  ciphered.join
end

puts 'Enter string:'
input = gets.chomp
shift = 0

loop do
  puts 'Enter shift:'
  shift = gets.chomp.to_i

  unless shift.zero?
    shift *= -1 if shift.negative?
    break
  end
end

puts "Encoded with shift #{shift}:"
puts cipher input, shift
