class Node
  def initialize(value)
    @value = value
    @next = nil
    @prev = nil
  end

  attr_accessor :value, :next, :prev
end

class Deque
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def create_first_node(value)
    @head = Node.new(value)
    @tail = @head
  end

  def push(value)
    if @size.zero?
      create_first_node(value)
    else
      node = Node.new(value)
      node.prev = @tail
      @tail.next = node
      @tail = node
    end
    @size += 1
  end

  # prepends value to the front of the deque
  def unshift(value)
    if @size.zero?
      create_first_node(value)
    else
      node = Node.new(value)
      node.next = @head
      @head.prev = node
      @head = node
    end
    @size += 1
  end

  def pop
    tail_value = @tail.value
    @tail = @tail.prev
    @size -= 1
    tail_value
  end

  # remove and returns leading element
  def shift
    head_value = @head.value
    @head = @head.next
    @size -= 1
    head_value
  end
end
