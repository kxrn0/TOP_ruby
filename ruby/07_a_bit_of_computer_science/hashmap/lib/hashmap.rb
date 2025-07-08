# frozen_string_literal: true

require_relative 'list'
require_relative 'entry'

# HashMap
class HashMap
  attr_reader :length

  BASE_SIZE = 16

  def initialize(load_factor = 0.75)
    @load_factor = load_factor
    @buckets = Array.new BASE_SIZE
    @length = 0
  end

  def print_debug_info
    puts "capacity: #{@buckets.size}"
    puts "length: #{@length}"
    puts "load_factor * capacity: #{@load_factor * @buckets.size}"
    puts '---------'
  end

  def hash(key)
    code = 0
    n = 31

    key.each_char { |char| code = n * code + char.ord }

    code % @buckets.size
  end

  def set(key, value)
    index = hash key

    @buckets[index] = List.new if @buckets[index].nil?

    add_to_bucket key, value, @buckets[index]

    expand if full?
  end

  def get(key)
    index = hash key
    bucket = @buckets[index]

    return if bucket.nil?

    entry = bucket.find { |e| e.key == key }

    entry&.value
  end

  def has?(key)
    index = hash key
    bucket = @buckets[index]

    return false if bucket.nil?

    bucket.has? { |e| e.key == key }
  end

  def remove(key)
    index = hash key
    bucket = @buckets[index]

    return if bucket.nil?

    entry = bucket.remove { |e| e.key == key }

    @length -= 1

    contract if wasteful?

    entry.value
  end

  def clear
    @buckets = Array.new BASE_SIZE
    @length = 0
  end

  def keys
    items = []

    @buckets.each do |bucket|
      next if bucket.nil?

      bucket.each { |e| items.push e.key }
    end

    items
  end

  def values
    items = []

    @buckets.each do |bucket|
      next if bucket.nil?

      bucket.each { |e| items.push e.value }
    end

    items
  end

  def entries
    pairs = []

    @buckets.each do |bucket|
      next if bucket.nil?

      bucket.each { |e| pairs.push [e.key, e.value] }
    end

    pairs
  end

  private

  def full?
    @length > @buckets.size * @load_factor
  end

  def wasteful?
    @buckets.size * @load_factor > 2 * @length
  end

  def expand
    migrate @buckets.size * 2
  end

  def contract
    size = [@buckets.size / 2, BASE_SIZE].max

    migrate size if size > BASE_SIZE
  end

  def migrate(size)
    old_buckets = @buckets

    @length = 0

    @buckets = Array.new size

    old_buckets.each do |bucket|
      next if bucket.nil?

      until bucket.empty?
        entry = bucket.shift

        set entry.key, entry.value
      end
    end
  end

  def add_to_bucket(key, value, bucket)
    entry = bucket.find { |e| e.key == key }

    if entry.nil?
      bucket.append Entry.new(key, value)
      @length += 1
    else
      entry.value = value
    end
  end
end
