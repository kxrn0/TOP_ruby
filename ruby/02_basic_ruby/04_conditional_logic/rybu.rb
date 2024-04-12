=begin
  1.- What is a boolean?
  
  A value that is interpreted as true or false by Ruby.
=end

=begin
  2.- What are truthy values?

  Values that are not equal to the literal false, but that are threated the same by conditional constructs like if statements.
=end

=begin
  3.- Are the following considered true or false: nil, 0, "0", "", 1, [], {}, -1?

  Only nil is considered false, everything else is true.
=end

=begin
  4.- When do you use elsif?

  When there are three or more branching paths. It can be used with only two, but for that else is usually used.
=end

=begin
  5.- When do you use unless?

  In place of if !<condition>
=end

=begin
  6.- What do ||, and &&, and ! do?

  || is or, which evaluates to true if one of its expressions is true, otherwise false.

  && evaluates to true only if both of its expressions are true, otherwise it evaluates to false.

  ! negates an expression.
=end

=begin
  7.- What is shortcircuit evaluation?

  Using logical operators for control flow.
=end

=begin
  8.- What is returned by puts "woah" || true?

  true, since puts returns nil
=end

=begin
  9.- What is the ternary operator?

  A control flow operator of the form <expression> ? <first> : <second> that executes <first> if <expression> is truthy, otherwise it executes <second>.
=end

=begin
  When should you use a case statement?

  When replacing a set of if elsif statements by it would make the code more readable.
=end
