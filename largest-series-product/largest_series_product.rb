class Series
  # https://exercism.org/tracks/ruby/exercises/largest-series-product/solutions/CROUZET
  def initialize(string)
    raise ArgumentError if string.match?(/\D/)

    @string = string
  end

  def largest_product(span)
    # covers empy case, negative case or larger span than string length case
    raise ArgumentError unless span.between?(0, @string.length)

    @string.chars.each_cons(span).map { |slice| slice.map(&:to_i).reduce(:*) }.max
  end
end
