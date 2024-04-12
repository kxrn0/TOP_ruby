=begin
  1.- What is a stack trace?
  
  A representation of the structure of the program that highlights how functions were calling each other at some point.
=end

=begin
  2.- What is generaly the most useful line in a stack trace?

  The first one, since it will often show the line on which an error occurred, and will print the message of the corresponding error that caused
  the program to crash.
=end

=begin
  3.- What are the two things you can learn from the first line of a stack trace?

  The name of the file the error occurred in, and the line in which it occurred.
=end

=begin
  4.- How do puts and pry help you with the debugging process?

  Adding puts statements between lines can show the current values for the variables in the program, and we can check if they are what we were expecting.
=end

=begin
  5.- What should you use instead of puts for nil values?

  p
=end

=begin
  6.- Where should you start with debugging if you encounter a runtime error?

  I would start by reading the stack trace.
=end

=begin
  7.- Where should you start with debugging if your program runs but doesn't work the way you expect?

  I would start by requiring pry-byebug, and adding a binding.pry statement wherever I suspect the bug is.
=end