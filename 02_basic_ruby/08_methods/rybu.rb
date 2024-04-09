=begin
  1.- How would you create your own method?

  By enclosing its body in a def/end block. The name of the method comes after the def keyword, and any parameters come after after the name.
=end

=begin
  2.- How would you call your new method?

  With its name followed by the parameters optionally in parentheses if the lack of them would be ambiguous.
=end

=begin
  3.- How do you pass a variable to your method?

  In a non ambiguous scenario the parameter or parameters would follow the name of the method, the parameters would be separated by commas. If doing so could lead
  to ambiguity, the parameters would have to be enclosed by parentheses.
=end

=begin
  4.- How do you define default parameters for your method?

  By setting the parameters equal to the default values when declared in the method definition.
=end

=begin
  5.- What is the difference between explicit and implicit return?

  Explicit return uses the return keyword, and makes the method's return whatever expression follows it. Implicit return doesn't have a return statement, and returns
  whatever expression is last in the method.
=end

=begin
  6.- What is the difference between puts and return?

  puts is a method, and returns is a statement.
=end

=begin
  7.- How do you chain multiple methods together?

  The methods are called with parentheses, and chained together with the dot operator.
=end

=begin
  8.- Give an example of a valid method name, and an invalid one.

  Valid: method
  Invalid: 1method
=end

=begin
  9.- What is snake case?

  The convention of adding underscores between individual words in a method or variable name.
=end

=begin
  10.- What are some of Ruby's reserved words?

  if, do, end, def, else, elsif, while, loop, until, unless
=end

=begin
  11.- What do you call a method that returns true or false? What is their naming convention?

  They are refered to as predicate methods, and conventionally end with a question mark.
=end

=begin
  12.- What do bang methods do? What is their naming convention?

  Bang methods are expected to mutate the object they are called on, and their names conventionally end with an exclamation mark.
=end