# Finished in 0.030612s, 163.3346 runs/s, 163.3346 assertions/s.
# however quite hacky to to use limit from test case
class Prime
  LIMIT = 104_743

  def self.nth(upto)
    new.nth(upto)
  end

  def nth(upto)
    raise ArgumentError, 'upto must be greater than 0' unless upto.positive?

    primes(upto)
  end

  def primes(upto)
    # true == primes
    # false == composites
    sieve = [true] * (LIMIT + 1)
    primes = []

    (2..Math.sqrt(LIMIT)).each do |num|
      next unless sieve[num]

      (num**2..LIMIT).step(num) do |multiple|
        sieve[multiple] = false
      end
    end

    (2..LIMIT).each do |num|
      primes.push(num) if sieve[num]
      return primes.last if primes.size == upto
    end
  end
end

# https://exercism.org/tracks/ruby/exercises/nth-prime/solutions/remcopeereboom
# Finished in 0.040399s
class PrimeEfficient
  # after 2, 3 it's safe to increment by 2
  # this way we don't need to test each and every number sequentially
  @primes ||= [2, 3]

  def self.nth(n)
    raise ArgumentError, "No #{n}th prime." if n < 1

    i = @primes.last + 2
    while @primes.length < n
      @primes << i if prime? i
      i += 2
    end

    @primes[n - 1]
  end

  def self.prime?(candidate)
    sqrt = Math.sqrt(candidate)
    # if candidate is a perfect square, it's not prime
    # if any of primes can be divided by candidate withour reminder, candidate won't be prime
    @primes.all? do |prime|
      return true if prime > sqrt

      candidate % prime != 0
    end
  end
  # this way we're not exposing prime method
  private_class_method :prime?
end

# https://exercism.org/tracks/ruby/exercises/nth-prime/solutions/ErikSchierboom
# Not that efficient, however looks quite elegant with 6 increment
# and checking predessors and successors each time for eligibility to be prime num
# Finished in 1.797746s, 2.7813 runs/s, 2.7813 assertions/s.
module PrimeErik
  def self.nth(number)
    raise ArgumentError if number.zero?

    primes = [2, 3]
    current = 6
    while primes.size < number
      primes << current.pred unless primes.any? { |prime| (current.pred % prime).zero? }
      primes << current.succ unless primes.any? { |prime| (current.succ % prime).zero? }
      current += 6
    end
    primes[number - 1]
  end
end

# https://exercism.org/tracks/ruby/exercises/nth-prime/solutions/s2k
# nice! Also had an idea to extend Integer class
# seems this will require least amount of space among all solutinos
class Integer
  def prime?
    return false if self <= 1

    (2..Integer.sqrt(self)).none? { |i| (self % i).zero? }
  end
end

# Finished in 0.151183s
module PrimeS2k
  def self.nth(n)
    raise ArgumentError, "There's no zeroth prime" if n.zero?

    prime = nil
    count = 0
    # 2 to Infinity
    (2..).each do |i|
      if i.prime?
        count += 1
        prime = i
      end
      break if count == n
    end
    prime
  end
end
