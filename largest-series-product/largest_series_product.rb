class Series
  class NegativeSpanError < ArgumentError; end
  class UnexpectedCharError < ArgumentError; end
  class EmptyStringError < ArgumentError; end
  class ProductLargerStringLengthError < ArgumentError; end

  def initialize(string)
    @string = validate_string(string)
  end

  def largest_product(span)
    validate_span(span)

    @string.chars.each_cons(span).map { |slice| slice.map(&:to_i).reduce(&:*) }.max
  end

  def validate_string(string)
    raise UnexpectedCharError unless (string =~ /\D/).nil?
    raise EmptyStringError if string.empty?

    string
  end

  def validate_span(span)
    raise NegativeSpanError if span.negative?
    raise ProductLargerStringLengthError if span > @string.length
  end
end
