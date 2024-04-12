def cipher string, shift
  length = 26
  chars = string.split ""
  ciphered = chars.map do |char|
    next char unless char.match? /[a-z]/i

    ascii_shift = char == char.upcase ? 65 : 97
    order = char.ord - ascii_shift
    reordered = (order + shift) % length
    chared = (reordered + ascii_shift).chr

    chared 
  end

  ciphered.join
end

puts "Enter string:"
input = gets.chomp
shift = 0

loop do
  puts "Enter shift:"
  shift = gets.chomp.to_i

  unless shift == 0
    shift *= -1 if shift < 0
    break
  end
end

puts "Encoded with shift #{shift}:"
puts cipher input, shift
