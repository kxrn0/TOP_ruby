def solution
  print "Enter a number > "
  number = gets.chomp.to_i

  if number.between? 0, 50
    puts "The number is between 0 and 50."
  elsif number.between? 51, 100
    puts "The number is between 51 and 100."
  elsif number > 100
    puts "The number is above 100."
  else
    puts "The number is negative or it doesn't exist."
  end
end

done = false

unless done
  solution

  print "Play again (y / n)? > "
  choice = gets.chomp.downcase

  if choice == "n"
    done = true
  end
end
