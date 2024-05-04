class Triangle
  def initialize(sides)
    @sides = sides
  end

  def valid_triangle?
    @sides.all?(&:positive?) && (
      @sides[0] + @sides[1] >= @sides[2] &&
      @sides[1] + @sides[2] >= @sides[0] &&
      @sides[0] + @sides[2] >= @sides[1]
    )
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
