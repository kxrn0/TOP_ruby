require_relative "node.rb"

class List
  def initialize
    @head = nil
  end

  def put newData
    raise "No condition given!" unless block_given?

    temp = @head

    while temp
      if yield temp.data
        temp.data = newData

        return
      end

      temp = temp.next_node
    end

    self.append newData
  end
  
  def get
    raise "No condition given!" unless block_given?

    temp = @head

    while temp
      return temp.data if yield temp.data

      temp = temp.next_node
    end
  end

  def append(data)
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

  def prepend(data)
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
    @head.data
  end

  def tail
    return @head unless @head

    temp = @head

    while temp.next_node
      temp = temp.next_node
    end

    temp.data
  end

  def at(index)
    current = 0
    temp = @head

    while temp && current <= index
      break if current == index

      temp = temp.next_node
      current += 1
    end

    raise "Index out of bounds!" if current < index

    temp.data
  end

  def pop
    raise "List is empty!" unless @head

    unless @head.next_node
      node = @head

      @head = nil

      return node.data
    end

    prev = nil
    current = @head

    while current.next_node
      prev = current
      current = current.next_node
    end

    prev.next_node = nil
    current.data
  end

  def shift
    raise "List is empty!" unless @head

    node = @head
    @head = @head.next_node
    node.data
  end

  def contains?(item = nil)
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

  def find(item = nil)
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

    string += "nil"
  end

  def insert_at(value, index)
    return self.prepend value if index == 0

    prev = nil
    current = @head
    currentIndex = 0

    while current && currentIndex < index
      currentIndex += 1
      prev = current
      current = current.next_node
    end

    raise "Index out of bounds!" if currentIndex < index

    node = Node.new value, current
    prev.next_node = node

    node
  end

  def remove_at(index)
    raise "List is empty!" unless @head

    return self.shift if index == 0

    prev = nil
    current = @head
    currentIndex = 0

    while current.next_node && currentIndex < index
      currentIndex += 1
      prev = current
      current = current.next_node
    end

    raise "Index out of bounds!" if currentIndex < index

    prev.next_node = current.next_node
    current
  end

  def remove
    raise "No condition given!" unless block_given?
    
    return nil unless @head
    return self.shift if yield @head.data

    prev = @head
    current = @head.next_node

    while current
      if yield current.data
        prev.next_node = current.next_node

        return current.data
      end

      prev = current
      current = current.next_node
    end
  end
end
