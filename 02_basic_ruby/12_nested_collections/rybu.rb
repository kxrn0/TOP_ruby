=begin
  1.- What is a nested array? What data is useful to store in a nested array?

  An array inside of another array. Multidimensional arrays are useful for modeling linear algebra algorithms where there can be many rows and columns of numbers.
=end

=begin
  2.- What is a nested hash? What data is useful to store in a nested hash?

  A hash inside of another hash. Any useful data that can be stored in a hash can be also stored in a nested hash. For example, if we have a hash where the keys are 
  the ids of employees, the employees can be hashes, which in turn can have a property that keeps track of the balances in their accounts.
=end

=begin
  3.- How do you access elements in a nested array?

  With the [] operator, like with regular arrays.
=end

=begin
  4.- How do you access data in a nested hash?

  With the [] operator, like in a regular hash.
=end

=begin
  5.- Why is the #dig method useful?

  Because if we try to access data the way we do it for a hash or an array on nil an error is thrown. With dig we just get nil, so we don't have to worry about handling exceptions.
=end

=begin
  6.- How do you add elements to a nested array?

  Since a nested array is just an array, data is added to them the way data is added to an array.
=end

=begin
  7.- How do you delete elements from a nested array?

  Since a nested array is just an array, data is removed from them with the #delete, or #delete_at method.
=end

=begin
  8.- How do you delete data in a nested hash?

  Since a nested hash is just a regular hash, with the #delete method.
=end

=begin
  10.- How do you create a new nested array that is not mutable?

  By following the call of Array.new(<size>) with a block that will evaluate to the desired array.
=end

=begin
  11.- How do you iterate over a nested array?

  With a nested loop.
=end

=begin
  12.- How do you iterate over a nested hash?

  With a nested loop.
=end
