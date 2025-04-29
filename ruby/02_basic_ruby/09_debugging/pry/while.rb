require "pry-byebug"

def fun(number)
  number.times do |i|
    binding.pry
    puts "current: #{i}"
  end
end

fun 10
