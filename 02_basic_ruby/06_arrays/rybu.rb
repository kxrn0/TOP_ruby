=begin
  1.- What is an array, and why is it useful?

  An array is an object that can hold many values which are indexed with numbers starting from zero.
  Arrays are useful because we can keep track of many values at the same time by only knowing the array's name
  and length.
=end

=begin
  2.- What are two ways to create a new empty array?

  By setting a variable to [], or Array.new
=end

=begin
  3.- What are some ways of accessing the elements of an array?

  With the [] operator where the index goes between the square braces. Positive values get the value at the given index,
  if there's any. Negative values get the value by counting from the end of the array.
  We can also use the first and last methods. They take a number which is the number of elements we want. So arr.last(5)
  tries to get the last five elements. If no argument is provided to those methods, they behave as if we had provided 1.
=end

=begin
  4.- What are three ways to add data to an array?

  With the .push method, the shovel operator, and the .unshift method.
=end

=begin
  5.- How can you remove elements from an array?

  With the .pop, .shift, .delete, .delete_at, .delete_if, and probably many more.
=end
