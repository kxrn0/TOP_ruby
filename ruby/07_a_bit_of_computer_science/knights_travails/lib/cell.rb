# frozen_string_literal: true

# Cell class
class Cell
  attr_accessor :parent
  attr_reader :x, :y

  def self.from_a(rray)
    Cell.new rray[0], rray[1]
  end

  def initialize(col, row)
    @x = col
    @y = row
    @parent = nil
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  def to_a
    [@x, @y]
  end

  def to_s
    "#{@x},#{@y}"
  end
end
