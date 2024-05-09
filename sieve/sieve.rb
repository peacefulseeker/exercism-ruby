class Sieve
  def initialize(limit)
    @limit = limit
  end

  def primes
    nums = (2..@limit).to_a
    non_primes = []
    primes = []
    nums.each do |num|
      multiples = @limit / num
      (2..multiples).each { |multiple| non_primes.push(num * multiple) }
      primes.push(num) unless non_primes.include?(num)
    end

    primes
  end
end
