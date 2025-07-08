# frozen_string_literal: true

require_relative 'list'

# Set
class HashSet
  BASE_SIZE = 16

  attr_reader :length

  def initialize(load_factor = 0.75)
    @load_factor = load_factor
    @buckets = Array.new BASE_SIZE
    @length = 0
  end

  def hash(key)
    code = 0
    n = 31

    key.each_char { |char| code = n * code + char.ord }

    code % @buckets.size
  end

  def add(key)
    index = hash key

    @buckets[index] = List.new if @buckets[index].nil?

    add_to_bucket key, @buckets[index]

    expand if full?
  end

  def has?(key)
    index = hash key
    bucket = @buckets[index]

    return false if bucket.nil?

    bucket.has? { |e| e == key }
  end

  def remove(key)
    index = hash key
    bucket = @buckets[index]

    result = bucket&.remove { |e| e == key }

    @length -= 1 unless result.nil?

    contract if wasteful?

    result
  end

  def clear
    @buckets = []
    @length = 0
  end

  def entries
    items = []

    @buckets.each do |bucket|
      next if bucket.nil?

      bucket.each { |e| items.push e }
    end

    items
  end

  private

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

      add bucket.shift until bucket.empty?
    end
  end

  def full?
    @length > @buckets.size * @load_factor
  end

  def wasteful?
    @buckets.size * @load_factor > 2 * @load_factor
  end

  def add_to_bucket(key, bucket)
    entry = bucket.find { |e| e == key }

    return unless entry.nil?

    bucket.append key
    @length += 1
  end
end
