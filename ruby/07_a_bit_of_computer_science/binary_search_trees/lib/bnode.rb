# frozen_string_literal: true

# BST Node
class BNode
  include Comparable

  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def <=>(other)
    @value <=> other.value
  end

  def to_s
    @value.to_s
  end
end
