class PythagoreanTriplet
  def self.triplets_with_sum(sum)
    a = 1
    combinations = []

    while (sum - a) / 2 > a
      b = a + 1
      c = sum - a - b

      while a + b + c == sum && b < c
        combinations.push([a, b, c]) if a**2 + b**2 == c**2
        b += 1
        c = sum - a - b
      end

      a += 1
    end

    combinations
  end
end
