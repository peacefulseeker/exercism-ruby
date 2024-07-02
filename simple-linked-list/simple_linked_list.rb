class Element
  def initialize(datum)
    @datum = datum
    @next = nil
  end

  attr_accessor :datum, :next
end

class SimpleLinkedList < Array
  def initialize(array = [])
    elements = array.map { |datum| Element.new(datum) }
    super(elements)
  end

  def to_a
    map(&:datum).reverse
  end
end
