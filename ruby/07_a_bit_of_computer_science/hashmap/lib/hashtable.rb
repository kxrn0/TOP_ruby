require_relative "list.rb"
require_relative "pair.rb"

class HashTable
  def initialize
    @capacity = 16
    @load_capacity = 0.75
    @pairCount = 0
    @buckets = Array.new(@capacity) { List.new }
  end

  def migrate
    @capacity = @buckets.size * 2
    tempBucket = Array.new(@capacity) { List.new }
    
    @buckets.each do |list|
      node = list.head

      while node
        pair = node.data
        index = (HashTable.hash pair.key) % @capacity

        tempBucket[index].append pair

        node = node.next_node
      end
    end
  end

  def set(key, value)
    if @pairCount >= @capacity * @load_capacity
      migrate
    end

    pair = Pair.new key, value
    index = (HashTable.hash key) % @capacity
    
    @buckets[index].put(pair) { |other| other.key == pair.key }
  end

  def to_s
    string = ""

    @buckets.each { |bucket| string += "#{bucket.to_s}\n"}
    
    string
  end

  def self.hash(string)
    code = 0
    p = 31

    string.each_char { |char| code = p * code + char.ord }

    code
  end
  
  
end