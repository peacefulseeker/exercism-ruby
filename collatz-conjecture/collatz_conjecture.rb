class CollatzConjecture
  class NonPositiveNumberError < ArgumentError; end

  def self.steps(num, steps = 0)
    raise NonPositiveNumberError unless num.positive?

    return steps if num == 1

    num = num.even? ? num / 2 : num * 3 + 1
    steps(num, steps + 1)
  end
end

# https://exercism.org/tracks/ruby/exercises/collatz-conjecture/solutions/KatieWright26
class CollatzConjectureNonRecursive
  def self.steps(num)
    raise ArgumentError if num <= 0

    count = 0
    until num == 1
      num = num.even? ? num / 2 : num * 3 + 1
      count += 1
    end
    count
  end
end
