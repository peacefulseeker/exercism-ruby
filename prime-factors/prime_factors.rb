class PrimeFactors
  def self.of(number)
    start = 2
    factors = []
    until number == 1
      if (number % start).zero?
        number /= start
        factors.push(start)
      else
        start += 1
      end
    end
    factors
  end
end

# recusrive approaches, but still prefer more readable loop to be honest
# good to know about .then method block
# https://exercism.org/tracks/ruby/exercises/prime-factors/solutions/CROUZET
# class PrimeFactors
#   def self.of(number)
#     return [] unless number > 1

#     next_factor(number).then do |factor|
#       [factor] + PrimeFactors.of(number / factor)
#     end
#   end

#   def self.next_factor(number)
#     (2..number).find { |factor| number.modulo(factor).zero? }
#   end
# end

# https://exercism.org/tracks/ruby/exercises/prime-factors/solutions/jchunky
# class PrimeFactors
#   def self.of(n)
#     return [] if n < 2

#     factor = (2..n).find { |i| n % i == 0 }
#     [factor] + of(n / factor)
#   end
# end
