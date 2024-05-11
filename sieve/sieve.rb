# O(n log n)
class Sieve
  def initialize(limit)
    @limit = limit
  end

  def primes
    marked = []
    primes = []
    (2..@limit).each do |num|
      (num**2..@limit).step(num) { |multiple| marked.push(multiple) }
      primes.push(num) unless marked.include?(num)
    end

    primes
  end
end

# O(n^2)
class Sieve2
  START_LIMIT = 2
  def initialize(limit)
    @list = (START_LIMIT..limit).to_a
    sieve
  end

  def primes
    @list
  end

  private

  def sieve
    @list.each do |factor|
      remove_multiple(factor)
    end
  end

  def remove_multiple(factor)
    @list.reject! do |number|
      number != factor && (number % factor).zero?
    end
  end
end

# O(n log log n)
# quite interesting approach of having array with true/false values
class SieveEratosthenes
  def initialize(limit)
    @limit = limit
  end

  def primes
    sieve = [true] * (@limit + 1)
    primes = []

    # square root of @limit
    (2..Math.sqrt(@limit)).each do |num|
      next unless sieve[num]

      (num**2..@limit).step(num) do |multiple|
        sieve[multiple] = false
      end
    end

    (2..@limit).each do |num|
      primes.push(num) if sieve[num]
    end

    primes
  end
end
