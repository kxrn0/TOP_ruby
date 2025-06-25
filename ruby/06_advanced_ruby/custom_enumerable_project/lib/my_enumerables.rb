# frozen_string_literal: true

# Enumerable module
module Enumerable
  # Your code goes here
  def my_each_with_index
    size.times do |index|
      item = self[index]

      yield item, index
    end

    self
  end

  def my_select
    selected = []

    size.times do |index|
      item = self[index]

      selected.push item if yield item
    end

    selected
  end

  def my_all?
    size.times do |index|
      return false unless yield self[index]
    end

    true
  end

  def my_any?
    size.times do |index|
      return true if yield self[index]
    end

    false
  end

  def my_none?
    size.times do |index|
      return false if yield self[index]
    end

    true
  end

  def my_count
    return size unless block_given?

    count = 0

    size.times do |index|
      count += 1 if yield self[index]
    end

    count
  end

  def my_map
    mapped = []

    size.times do |index|
      mapped.push yield self[index]
    end

    mapped
  end

  def my_inject(initial_value = nil)
    result = initial_value || 0

    size.times do |index|
      result = yield result, self[index]
    end

    result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    size.times do |index|
      yield self[index]
    end

    self
  end
end
