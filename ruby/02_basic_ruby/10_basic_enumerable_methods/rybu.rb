=begin
  1.- What does the #each method do? What does it return?
  
  It applies the block it's given to each item in an iterable.
  It returns the original iterable.
=end

=begin
  2.- What does the #each_with_index method do?

  It applies the block it's given to each element in an iterable. For every run, it gives access to the current element and
  its index in the iterable.
=end

=begin
  3.- What does the #map method do?

  It applies the block it's given to each element in an iterable, stores the result in a new iterable which it returns 
  once it's done.
=end

=begin
  4.- What does the #select method do?

  It creates a new iterable with only the elements of the iterable it's called on that make the provided block return a 
  truthy value.
=end

=begin
  5.- What does the #reduce method do?

  It generates a value from an iterable. The return value of the provided block is used to keep track of the current state of
  the accumulator.
=end

=begin
  6.- When should you use a do/end around a code block versus {...}?
  
  When the body of the block is too complex to fit in one line.
=end

=begin
  7.- Why should you avoid using the bang operator on enumerables?

  Since the bang mutates the object it's called on, information can be lost, which makes reasoning about the program harder.
=end