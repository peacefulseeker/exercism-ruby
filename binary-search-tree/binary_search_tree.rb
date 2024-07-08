class Bst
  def initialize(data)
    @root = Node.new(data)
  end

  def to_s
    data
  end

  def data
    @root.data
  end

  def left
    @root.left
  end

  def right
    @root.right
  end

  def insert(data)
    cur = @root

    while cur
      if cur.left && data <= cur.data
        cur = cur.left
      elsif cur.right && data > cur.data
        cur = cur.right
      else
        break cur
      end
    end
    if data <= cur.data
      cur.left = Node.new(data)
    else
      cur.right = Node.new(data)
    end
  end

  def inorder_traverse(node, data = [])
    return if node.nil?

    inorder_traverse(node.left, data)
    data << node.data
    inorder_traverse(node.right, data)

    data
  end

  def traverse
    inorder_traverse(@root)
  end

  def each(&block)
    traverse.each(&block)
  end
end

class Node
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  attr_accessor :data, :left, :right

  def to_s
    data
  end
end
