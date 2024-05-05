class Triangle
  def initialize(sides)
    @sides = sides
  end

  def valid_triangle?
    @sides.all?(&:nonzero?) &&
      # @sides = [5, 4, 6]
      # [5, 4, 6].combination(2) = [[5, 4], [5, 6], [4, 6]]
      # 2 sides combinations + third side as array item
      # [[5, 4], [5, 6], [4, 6]].zip([6, 4, 5]) = [[[5, 4], 6], [[5, 6], 4], [[4, 6], 5]]
      @sides.combination(2).zip(@sides.reverse).all? { |a, b| a.sum >= b }
  end

  def equilateral?
    valid_triangle? && @sides.uniq.size == 1
  end

  def isosceles?
    valid_triangle? && @sides.uniq.size <= 2
  end

  def scalene?
    valid_triangle? && @sides.uniq.size == @sides.size
  end
end
