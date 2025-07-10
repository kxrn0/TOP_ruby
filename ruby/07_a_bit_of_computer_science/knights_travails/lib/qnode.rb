# frozen_string_literal: true

# Node
class QNode
  attr_accessor :data, :succ, :pred

  def initialize(data, succ, pred)
    @data = data
    @succ = succ
    @pred = pred
  end
end
