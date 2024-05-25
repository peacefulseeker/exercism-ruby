class CollatzConjecture
  class NonPositiveNumberError < ArgumentError; end

  def self.steps(number, steps = 0)
    raise NonPositiveNumberError unless number.positive?

    return steps if number == 1

    if number.even?
      number /= 2
    else
      number *= 3
      number += 1
    end

    steps(number, steps + 1)
  end
end
