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
