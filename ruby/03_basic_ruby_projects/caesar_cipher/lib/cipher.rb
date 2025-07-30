# frozen_string_literal: true

def shift_char(char, shift)
  return char unless char.match?(/[a-z]/i)

  alphabet_size = 26

  ascii_shift = char == char.upcase ? 65 : 97
  order = char.ord - ascii_shift
  reordered = (order + shift) % alphabet_size

  (reordered + ascii_shift).chr
end

def cipher(string, shift)
  chars = string.split ''
  ciphered = chars.map do |char|
    shift_char char, shift
  end

  ciphered.join
end
