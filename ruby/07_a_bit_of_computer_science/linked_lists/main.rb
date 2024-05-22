class List
  def initialize
    @head = nil
  end

  def append data
    node = Node.new data, nil
    
    unless @head

      @head = node
      
      return
    end

    temp = @head

    while temp.next_node
      temp = temp.next_node
    end

    temp.next_node = node
  end
  
  def prepend data
    node = Node.new data, @head

    @head = node
  end
  
  def size
    return 0 unless @head

    sum = 1
    temp = @head

    while temp.next_node
      sum += 1

      temp = temp.next_node
    end

    sum
  end

  def head
    @head
  end
  
  def tail
    return @head unless @head

    temp = @head

    while temp.next_node
      temp = temp.next_node
    end

    temp
  end
  
  def at index
    current = 0
    temp = @head

    while temp && current <= index
      break if current == index

      temp = temp.next_node
      current += 1  
    end
    
    raise "Index out of bounds!" if current < index

    temp
  end

  def pop
    raise "List is empty!" unless @head
    
    prev = nil
    current = @head

    while current.next_node
      prev = current
      current = current.next_node
    end

    prev.next_node = nil
    current
  end

  def shift
    raise "List is empty!" unless @head

    @head = @head.next_node
  end
  
  def contains? item = nil
    temp = @head
    
    while temp
      if block_given?
        return true if yield temp.data
      else
        return true if item == temp.data
      end

      temp = temp.next_node
    end

    false
  end

  def find item = nil
    index = 0
    temp = @head

    while temp
      if block_given?
        return index if yield temp.data
      else
        return index if item == temp.data
      end

      temp = temp.next_node
      index += 1
    end
  end

  def to_s
    string = ""
    temp = @head

    while temp
      string += "(#{temp.data}) -> "
      temp = temp.next_node
    end

    string += " nil"
  end

  def insert_at value, index
    return self.prepend value if index == 0

    prev = nil
    current = @head
    jndex = 0

    while current && jndex < index
      jndex += 1
      prev = current
      current = current.next_node
    end

    raise "Index out of bounds!" if jndex < index

    node = Node.new value, current
    prev.next_node = node

    node
  end

  def remove_at index
    return self.shift if index == 0

    prev = nil
    current = @head
    jndex = 0

    while current.next_node && jndex < index
      jndex += 1
      prev = current
      current = current.next_node
    end

    raise "Index out of bounds!" if jndex < index

    prev.next_node = current.next_node
    current
  end

end

class Node
  attr_accessor :data, :next_node

  def initialize data, next_node
    @data = data
    @next_node = next_node
  end

  def to_s
    "#{data}"
  end
end
