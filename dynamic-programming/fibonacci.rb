# Learning from https://www.youtube.com/watch?v=Hdr64lKQ3e4
require 'benchmark'

class Fibonacci
  def self.fib(n)
    return 1 if n <= 2

    fib(n - 1) + fib(n - 2)
  end
end

# fundamental idea of dynamic programming -> recursion + memoization
# - start by defining the subproblem
# - figure out the base case
# - find recursive formula for general solution
# - (visualization helps a lot)

class FibonacciDynamic
  MEMO = {} # rubocop:disable Style/MutableConstant

  class << self
    def fib(n)
      return MEMO[n] if MEMO[n]

      result = if n <= 2
                 1
               else
                 fib(n - 1) + fib(n - 2)
               end
      MEMO[n] = result
      result
    end

    def clear
      MEMO.clear
    end

    def memo
      MEMO
    end
  end
end

# recursion_time = Benchmark.measure do
#   Fibonacci.fib(40)
# end

# memoized_recursion_time = Benchmark.measure do
#   FibonacciDynamic.fib(40)
# end

Benchmark.bm(20) do |x|
  x.report('recursion:') { Fibonacci.fib(40) } # wtuh 50 would already take forever
  x.report('memoized_recursion:') { FibonacciDynamic.fib(40) }
end

# user     system      total        real
# recursion:             4.659067   0.005550   4.664617 (  4.721737)
# memoized_recursion:    0.000013   0.000003   0.000016 (  0.000016)

# puts FibonacciDynamic.fib(5)
# puts FibonacciDynamic.fib(40)
# puts FibonacciDynamic.memo
# puts FibonacciDynamic.clear
