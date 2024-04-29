class Series
  def initialize(string)
    @string = string
  end

  def slices(num)
    raise ArgumentError if num > @string.length || num.negative? || num.zero?

    # mapping = @string.chars.map.with_index do |_, index|
    #   @string[index..index + num - 1]
    # end
    # mapping.select { |i| i.size == num }

    # this might raise ArgumentError(invalid size) in case of wrong num spec
    @string         # assuming n == 2 :
      .each_char    # %w(s t r i n g)
      .each_cons(num) # [%w(s t), %w(t r), %w(r i), %w(i n), %w(n g)]
      .map(&:join) # %w(st tr ri in ng)
  end
end
