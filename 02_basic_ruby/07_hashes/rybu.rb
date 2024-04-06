=begin
  1.- What are the differences between hashes and arrays? 
  
  Array elements are retrieved from an array with integers, while hash values are retrieved with keys that can be of any type, but more often symbols.
  In an array the elements are ordered, but not so in hashes. Elements are ordered in hashes in newer versions of ruby, but many ancient codebases that
  still use older versions of ruby can't count on that.
=end

=begin
  2.- What are keys and values in a hash?

  A key in a hash is what is used to access a piece of data stored by the hash. This piece of data is usually known as a value.
=end

=begin
  3.- How can you create a new hash?

  A hash with symbols for keys can be created the way an object in javaScript is created. If we want the keys to be something other than symbols we use the
  hash rocket syntax. Between curly braces we write the key on the left, then the hash rocket, and the value on the right. We separate the key value pairs with
  commas if there are more than one.
=end

=begin
  3.- How can you populate a hash with data?

  We can add a key value pair to a hash by using the syntax we use to access values, and setting that equal to the value we want to add.
=end

=begin
  4.- How can you change existing values within a hash?

  The way new key value pairs are added, but instead of a new key we use an existing one.
=end

=begin
  5.- How can you delete existing data from a hash?

  With the .delete method. We call the method with the key we want to delete.
=end

=begin
  6.- How can you merge two hashes togheter?

  With the merge hash method.
=end

=begin
  7.- Why is it preferred to use symbols as hash keys?

  They are more performant than strings, and more descriptive than numbers.
=end
