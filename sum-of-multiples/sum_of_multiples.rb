class SumOfMultiples
  def initialize(*factors)
    @factors = factors
  end

  def to(limit)
    # result = @factors.map do |multiple|
    #   (1...limit).select { |n| (n % multiple).zero? }
    # end

    # result.flatten.uniq.sum

    # https://exercism.org/tracks/ruby/exercises/sum-of-multiples/solutions/ErikSchierboom
    # select among range of numbers, instead of mapping factors.
    # only those which can be divided by any of the factors without a remainder
    (1...limit)
      .select { |n| @factors.any? { |factor| (n % factor).zero? } }
      .sum
  end
end
