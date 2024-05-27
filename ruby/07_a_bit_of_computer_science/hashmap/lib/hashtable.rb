require_relative "list.rb"
require_relative "pair.rb"

class HashTable
  def initialize
    @capacity = 16
    @load_capacity = .75
    @pairCount = 0
    @buckets = Array.new @capacity
  end

  def migrate
    puts "migrating..."
  end

  def set_key(key, value)
    if @pairCount >= @capacity * @load_capacity
      migrate
    end

    index = (HashTable.hash key) % @capacity
    
    puts index

    node = @buckets[index]
    if node.nil?
      bucket = List.new
      pair = Pair.new key, value
      bucket.append pair
    else
      # If the bucket is not empty, see if there's already an item in the list
      # with the given key, if so, replace the value in it with the new value,
      # otherwise append it to the end of the list
      
    end
  end

  def to_s
    "#{@buckets}"
  end

  def self.hash(string)
    code = 0
    p = 31

    string.each_char { |char| code = p * code + char.ord }

    code
  end
  
  
end