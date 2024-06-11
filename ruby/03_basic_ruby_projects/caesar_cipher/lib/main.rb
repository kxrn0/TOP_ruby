def cipher string, shift
  length = 26
  chars = string.split ""
  ciphered = chars.map do |char|
    next char unless char.match?(/[a-z]/i)

    ascii_shift = char == char.upcase ? 65 : 97
    order = char.ord - ascii_shift
    reordered = (order + shift) % length
    chared = (reordered + ascii_shift).chr

    chared 
  end

  ciphered.join
end
