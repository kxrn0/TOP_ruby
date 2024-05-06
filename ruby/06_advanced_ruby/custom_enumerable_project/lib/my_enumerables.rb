module Enumerable
  # Your code goes here

  def my_each
    for element in self
      yield element
    end
  end

  def my_each_with_index
    i = 0
    while i < self.size
      yield self[i], i

      i += 1
    end

    self
  end

  def my_select
    pass = []

    self.each do |item|
      pass.push item if yield item
    end

    pass
  end

  def my_all?
    self.each do |item|
      value = yield item

      return false unless value
    end

    true
  end

  def my_any?
    self.each do |item|
      return true if yield(item)
    end
    
    false
  end

  def my_none?
    self.each do |item|
      value = yield item

      return false if value
    end

    true
  end

  def my_count
    return self.size unless block_given?

    count = 0

    self.reduce(0) do |tot, curr|
      tot + (yield(curr) ? 1 : 0)
    end
  end

  def my_map
    map = []

    self.each do |item|
      map.push(yield item)
    end

    map
  end

  def my_inject(initial_value = 0)
    total = initial_value

    self.each do |item|
      total = yield total, item
    end

    total
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  include Enumerable
end
