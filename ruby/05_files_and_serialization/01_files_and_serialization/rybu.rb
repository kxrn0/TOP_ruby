=begin
  1.- How would you go through the lines of a file using an IO object?

  I'd open it with "r" permission, and use gets until it returns null

  ```
    descriptor = IO.sysopen "my_file.txt", "r"
    file = IO.new descriptor

    while line = file.gets
      puts line
    end

    file.close
  ```
=end

=begin
  2.- How would you take the array [1, 2, 3], and serialize it into JSON?

  With the native JSON utility

  ```
    require "json"

    array = [1, 2, 3]
    serialized = JSON.dump array

    puts serialized
  ```
=end

=begin
  2.- What are the benefits of YAML vs JSON vs MessagePack?

  JSON is very common in the javascript world, and all modern browsers understand it, so it's ideal for APIs.
  MessagePack is best for when bandwidth is of concern, since the size of the serialized object is smaller than what we would get 
  with JSON or YAML.
  YAML is human readable.
=end

=begin
  3.- How can you check if a file or directory exists?

  With the `Dir.exist?` method.
=end

=begin
  4.- How can you list a directory's contents in the form of an array?

  With the `Dir.entries` method.
=end
