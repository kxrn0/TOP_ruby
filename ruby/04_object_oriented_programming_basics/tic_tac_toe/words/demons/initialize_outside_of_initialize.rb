# frozen-string-literal: true

# A class to test the thing...
class Klass
  def set_thing
    @thing = 10
  end

  def return_thing
    @thing
  end
end

instance = Klass.new

puts instance.return_thing # nil

instance.set_thing

puts instance.return_thing # 10
