class Pair
  attr_accessor :key, :value

  def initialize key, value
    @key = key
    @value = value
  end
  
  def to_s
    "{ key: #{@key}, value: #{@value} }"
  end
end