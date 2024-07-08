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

  def insert(data, cur = @root)
    # insert into left branch
    if data <= cur.data
      if cur.left.nil?
        cur.left = Node.new(data)
      else
        insert(data, cur.left)
      end

    # insert into right branch
    elsif cur.right.nil?
      cur.right = Node.new(data)
    else
      insert(data, cur.right)
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
