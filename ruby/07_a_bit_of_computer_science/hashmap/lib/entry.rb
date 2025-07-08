# frozen_string_literal: true

# Key-value pair for a hash map
class Entry
  attr_accessor :value
  attr_reader :key

  def initialize(key, value)
    @key = key
    @value = value
  end
end
