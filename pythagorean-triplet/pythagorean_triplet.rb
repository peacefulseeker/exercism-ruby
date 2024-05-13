class PythagoreanTriplet
  def self.triplets_with_sum_(sum)
    a = 1
    combinations = []

    while 3 * a < sum
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

  # https://exercism.org/tracks/ruby/exercises/pythagorean-triplet/solutions/JakubSarnik
  # def self.triplets_with_sum__(n)
  #   (1...n).each_with_object([]) do |a, res|
  #     b = (n * (2 * a - n)) / (2 * (a - n)).to_f
  #     c = n - a - b
  #     res << [a, b.to_i, c.to_i] if b % 1 == 0 && a < b
  #   end
  # end

  # def self.triplets_with_sum(sum)
  #   # If a number (n) odd is given, then the Pythagorean triples are of the form, (n, (n2/2 - 0.5) and (n2/2 + 0.5)).
  #   # For example, consider 3. The triples are (3, (9/2 - 0.5), (9/2 + 0.5)). Finally, we get (3, 4 and 5).
  #   # If a number (n) even is given, then the Pythagorean triples are of the form, (n, (n/2)2-1), ((n/2)2+1).
  #   # For example, consider 8. The triples are (8, ((4)2 - 1), ((4)2 + 1)). Finally, we get (8, 15, and 17)

  #   a = 1
  #   combinations = []

  #   while 3 * a < sum
  #     if a.odd?
  #       b = a**2 / 2.to_f - 0.5
  #       c = a**2 / 2.to_f + 0.5
  #     else
  #       b = a**2 / 2 - 1
  #       c = a**2 / 2 + 1
  #     end
  #     combinations << [a, b, c] if a + b + c == sum && a**2 + b**2 == c**2

  #     a += 1
  #   end

  #   combinations
  # end

  # https://exercism.org/tracks/ruby/exercises/pythagorean-triplet/solutions/satyakampandya
  def self.triplets_with_sum(sum)
    triplets = []

    # Loop through possible values for side_a
    (1..sum / 3).each do |side_a|
      # Calculate side_b and side_c based on the sum and side_a
      side_b = (sum**2 - 2 * sum * side_a) / (2 * sum - 2 * side_a)
      side_c = sum - side_a - side_b

      # Check if it forms a Pythagorean triplet (side_a^2 + side_b^2 = side_c^2)
      if side_a**2 + side_b**2 == side_c**2
        # If it's a valid triplet, add it to the list of triplets
        triplets << [side_a, side_b, side_c].sort
      end
    end

    # Return the unique triplets found
    triplets.uniq
  end
end

# https://exercism.org/tracks/ruby/exercises/pythagorean-triplet/solutions/bigbob1256
# can learn a bit more about formula for generating triplets here
module PythagoreanTripletBigBob # :nodoc: all
  # For insights about the alogrithm I used, see https://en.wikipedia.org/wiki/Pythagorean_triple#Generating_a_triple

  def self.triplets_with_sum(sum)
    factors(sum / 2)
      .combination(2)
      .map { |m, p| [m, p - m] }
      .filter { |m, n| m > n && m % 2 != n % 2 && coprime?(m, n) }
      .map do |(m, n)|
        k = 1
        product = 2 * k * m * (m + n)
        while product < sum
          k += 1
          product = 2 * k * m * (m + n)
        end

        generate_triplet(k, m, n) if product == sum
      end.compact.sort_by(&:first)
  end

  def self.generate_triplet(k, m, n)
    [a(k, m, n), b(k, m, n), c(k, m, n)].sort
  end

  def self.a(k, m, n)
    k * (m**2 - n**2)
  end

  def self.b(k, m, n)
    k * (2 * m * n)
  end

  def self.c(k, m, n)
    k * (m**2 + n**2)
  end

  def self.factors(n)
    k = 1
    result = []
    until k * k > n
      result << k << n / k if (n % k).zero?
      k += 1
    end
    result
  end

  def self.gcd(a, b)
    b.zero? ? a : gcd(b, a % b)
  end

  def self.coprime?(a, b)
    gcd(a, b) == 1
  end
end
