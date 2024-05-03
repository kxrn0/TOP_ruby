=begin
  1.- What is a block?

  A piece of code that behaves like an anonymous function.
=end

=begin
  2.- How is a block like a method?

  It can take parameters and return a value.
=end

=begin
  3.- What are the two ways to declare a block?

  With the do/end syntax, and with curly braces.
=end

=begin
  4.- How do you return data from a block?

  The same way data is returned from a method.
=end

=begin
  5.- How can your methods collect the return data from a block?

  The block returns a value which can be collected in a variable.
=end

=begin
  6.- What happens if you include a retunr statement in a block?

  It returns early.
=end

=begin
  7.- What does yield do?

  It runs the block fed to the function.
=end

=begin
  8.- How do you pass arguments to a block method from within a method?

  By passing them to yield, which will pass them down to the block.
=end

=begin
  9.- How do you check whether a block was actually passed?

  With the block_given? property.
=end

=begin
  10.- What is a proc?

  An object that stores a block and that can call that block, so similar to a higher order function.
=end

=begin
  11.- What is a lambda?

  A special kind of proc with more restrictions about how it can be used.
=end

=begin
  12.- What's different between a lambda and a proc?

  A proc fills in missing parameters, and returns from the context it's called in, while the lambda errors out if it's given the wrong number of arguments, and returns from its own context. 
=end

=begin
  13.- How do you convert a proc to a block?

  By appending the & operator to it.
=end

=begin
  14.- How do you convert a block to a proc?

  By appending the & operator to it.
=end
