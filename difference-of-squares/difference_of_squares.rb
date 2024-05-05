class Range
  def square
    map { |num| num**2 }
  end
end

class Squares
  def initialize(num)
    @n = num
  end

  def square_of_sum
    (1..@n).sum**2
  end

  def sum_of_squares
    (1..@n).square.sum
  end

  def difference
    square_of_sum - sum_of_squares
  end
end
