class SumOfMultiples
  def initialize(*multiples)
    @multiples = multiples
  end

  def to(limit)
    result = @multiples.map do |multiple|
      (1..limit - 1).select { |n| (n % multiple).zero? }
    end

    result.flatten.uniq.sum
  end
end
