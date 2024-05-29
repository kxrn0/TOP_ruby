require_relative "list.rb"
require_relative "pair.rb"

class HashTable
  def initialize
    @min_capacity = 16
    self.reset
  end

  def reset
    @capacity = @min_capacity
    @max_load_ratio = 0.75
    @load_factor = 0.75
    @pair_count = 0
    @buckets = Array.new(@capacity) { List.new }
  end

  def migrate
    tempBuckets = Array.new(@capacity) { List.new }

    @buckets.each do |list|
      node = list.head

      while node
        pair = node.data
        index = HashTable.hash pair.key, @capacity

        tempBuckets[index].append pair

        node = node.next_node
      end
    end

    @buckets = tempBuckets
  end

  def set(key, value)
    if @pair_count / @capacity >= @max_load_ratio
      @capacity *= 2
      migrate
    end

    pair = Pair.new key, value
    index = HashTable.hash key, @capacity

    result = @buckets[index].put(pair) { |other| other.key == pair.key }

    @pair_count += 1 unless result
  end

  def get(key)
    index = HashTable.hash key, @capacity

    pair = @buckets[index].get { |pair| pair.key == key }

    pair ? pair.value : nil
  end

  def has?(key)
    @buckets.each do |bucket|
      return true if bucket.get { |pair| pair.key == key }
    end

    false
  end

  def remove(key)
    index = HashTable.hash key, @capacity

    result = @buckets[index].remove { |pair| pair.key == key }

    if result[:found]
      @pair_count -= 1

      if @pair_count / @capacity <= @max_load_ratio / 4 && @capacity > @min_capacity
        @capacity = [@min_capacity, @capacity / 2].max
        migrate
      end

      return result[:value]
    end
  end

  def length
    @pair_count
  end

  def clear
    self.reset
  end

  def keys
    all_keys = []

    @buckets.each do |bucket|
      all_keys += bucket.to_a { |pair| pair.key }
    end

    all_keys
  end

  def values
    all_values = []

    @buckets.each do |bucket|
      all_values += bucket.to_a { |pair| pair.value }
    end

    all_values
  end

  def entries
    all_entries = []

    @buckets.each do |bucket|
      all_entries += bucket.to_a { |pair| [pair.key, pair.value] }
    end

    all_entries
  end

  def to_s
    string = ""

    @buckets.each { |bucket| string += "#{bucket.to_s}\n" }

    string
  end

  def self.hash(string, capacity)
    code = 0
    p = 31

    string.each_char { |char| code = p * code + char.ord }

    code % capacity
  end
end
