def solution(str)
  if str.size <= 10
    str
  else
    str.upcase
  end
end

puts solution "hi"
puts solution "more than ten"
puts solution "less"
puts solution "many characters"
