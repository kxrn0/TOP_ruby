# frozen-string-literal: true

# hints class
class Hints
  attr_reader :pluses, :minuses

  def initialize(pluses, minuses)
    @pluses = pluses
    @minuses = minuses
  end

  def to_s
    "#{'+ ' * @pluses}#{'- ' * @minuses}"
  end
end
