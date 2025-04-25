=begin 
  1.- What are the basic arithmetic operators you can use on numbers?

  Addition +
  Subtraction -
  Multiplication * 
  Division /
  Exponentiation **
  Modulo %
=end

=begin
  2.- What is the difference between an integer and a float?

  An integer is a representation of an integer, and a float is an approximation of a real number.
  When dividing two integers the result will be the integer portion of the operation. To get the floating
  part as well, at least one of the integers has to be converted to float.
=end

=begin
  3.- What method would you use to convert a float to an integer?

  We can use the to_i method for that.
=end

=begin
  4.- What method would you use to convert an integer to a float?

  We can use the to_f method for that.
=end

=begin
  5.- What is a string?

  An arbitrary set of characters. A string is delimited by single or double
  quotes.
=end

=begin
  6.- What are the differences between single and double quotes?

  Only double quotes allow for string interpolation and escape characters. Single quotes can still escape single quotes with `\'`.
=end

=begin
  7.- What is string interpolation?

  Adding data to a string by using the #{} operator.
=end

=begin
  8.- How do you concatenate strings?

  You can use the + operator, the << operator, or the .concat method.
=end

=begin
  9.- What method would you use to change all the characters in your string to upper case?

  The .upcase method.
=end

=begin
  10.- What method would you use to split a string into an array?
  
  The .split method. When called without parameters it splits the string by spaces, getting rid of uneccessary ones. When called
  with a string parameter it splits the string by that substring. It can also take a regex and it splits at every match.
=end

=begin
  11.- What are escape characters?

  Characters that need to be represented in some other way to add them to a string, since adding them directly to the string
  would break it. An example is the newline character. A string can't have line breaks, so a escape characer for them is needed.
=ebd

=begin
  12.- How do you access a specific character or substring?

  With the [] operator. A single integer makes it return the character at that position, while a range takes a range of the string, so
=end

=begin
  13.- How do you convert other data types into strings?

  With the `.to_s` method, if they have one.
=end

=begin
  14.- What is a symbol?

  A symbol can be considered an immutable string. Two normal strings with the same characters are equal when evaluated with the
  == operator, but their object ids are different. Two symbols with the same characters are considered to be the same by the ==
  operator, and have the same object id.
=end

=begin
  15.- How do you create a symbol?

  By prepending an unbroken string with :, or a quote delimited string by the same character.
=end

=begin
  16.- What is the difference between a symbol and a string?

  Two different strings with the same characters in the same order are considered the same by the == operator, but have different
  object ids, while two symbols with the same characters in the same order are considered the same by the == operator,
  and will always have the same object id.
=end

=begin
  17.- What does true represent?

  True.
=end

=begin
  18.- What does false represent?

  False.
=end

=begin
  19.- What does nil represent?

  The absence of a value.
=end
