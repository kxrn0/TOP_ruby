require_relative "node.rb"

class List
  def initialize
    @head = nil
  end

  def put(newData)
    raise "No condition given!" unless block_given?

    temp = @head

    while temp
      if yield temp.data
        temp.data = newData

        return true
      end

      temp = temp.next_node
    end

    self.append newData

    return false
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

  def remove
    notFound = { found: false, value: nil }

    raise "No condition given!" unless block_given?

    return notFound unless @head
    if yield @head.data
      found = { found: true, value: @head.data }

      self.shift

      return found
    end

    prev = @head
    current = @head.next_node

    while current
      if yield current.data
        prev.next_node = current.next_node
        found = { found: true, value: current.data }

        return found
      end

      prev = current
      current = current.next_node
    end

    notFound
  end

  def to_a
    raise "No condition given!" unless block_given?

    array = []
    temp = @head

    while temp
      array.push yield temp.data

      temp = temp.next_node
    end

    array
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
end
