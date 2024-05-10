=begin
  1.- How would you briefly define a recursive function?

  A function that calls itself.
=end

=begin
  2.- What is the point of recursion? is it more efficient than using a plain loop?

  To simplify the logic of an algorithm. Recursion is often less efficient, specially if the
  language doesn't support tail call optimization.
=end

=begin
  3.- What are the two essential parts in a recursive function?

  The base case for breaking out of the loop, and the recursive call.
=end

=begin
  4.- Why is stack overflow relevant to a recursive problem?

  Every time a recursive call is made, the state of the function that made the call has to be stored somewhere,
  that somewhere is called the stack. Since computers have a finite amount of memory, if there are too many 
  recursive calls, the stack will fill all the available memory and the program will crash.
=end