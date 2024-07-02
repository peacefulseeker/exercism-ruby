class Element
  def initialize(datum)
    @datum = datum
  end

  attr_accessor :datum, :next
end

# simple stupid approach...
# couple of tests to ensure no inheritance used would not hurt
class SimpleLinkedListArray < Array
  def initialize(array = [])
    elements = array.map { |datum| Element.new(datum) }
    super(elements)
  end

  def to_a
    map(&:datum).reverse
  end
end

class SimpleLinkedList
  def initialize(array = [])
    array.each do |item|
      push(Element.new(item))
    end
  end

  attr_reader :head

  def push(element)
    element.next = @head
    @head = element
    self
  end

  def pop
    return nil if @head.nil?

    element = @head
    @head = @head.next
    element.next = nil
    element
  end

  def to_a
    res = []
    curr = @head
    until curr.nil?
      res << curr.datum
      curr = curr.next
    end
    res
  end

  # interesting approach which allows not to introduce @tail
  # https://exercism.org/tracks/ruby/exercises/simple-linked-list/solutions/kotp
  def reverse!
    previous = nil
    pointer = @head
    while pointer
      temp = pointer.next
      pointer.next = previous
      previous = pointer
      pointer = temp
    end
    @head = previous
    self
  end
end
