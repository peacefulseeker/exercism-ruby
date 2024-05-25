class Change
  class ImpossibleCombinationError < StandardError; end
  class NegativeTargetError < StandardError; end

  def self.generate(coins, target)
    return [] if target.zero?
    raise NegativeTargetError if target.negative?

    result = change_making(coins, target)
    raise ImpossibleCombinationError if result.empty?

    result

    # FAILED ATTEMPTS TO GET IT DONE
    # coins.select! { |coin| coin <= target }
    # coins.reverse!

    # options = []

    # coins.each.with_index do |coin, index|
    #   options.push([coin] * (target / coin)) if (target % coin).zero?

    #   left = target - coin
    #   options.push([left] + [coin]) if coins.include?(left)

    #   matched = coins[index..].find { |c| (left % c).zero? }
    #   options.push([matched] * (left / matched) + [coin]) if matched

    #   # coins[index + 1..].each do |c|
    #   #   left -= coins[index + 1]
    #   #   next if left.negative?

    #   #   matched = coins[index + 1..].find { |c| (left % c).zero? }
    #   #   pushing = [matched] * (left / matched) + [coins[index + 1], coin]
    #   #   options.push([matched] * (left / matched) + [coins[index + 1], coin]) if matched && pushing.sum == target
    #   # end
    # end
    # raise ImpossibleCombinationError if options.empty?

    # options.min_by(&:size)
  end
end

def get_change_making_matrix(coins, r)
  m = Array.new(coins.length + 1) { Array.new(r + 1) { 0 } }
  m[0].map!.with_index { |_, i| i == 0 ? 0 : Float::INFINITY } # Setting first row to 0 and rest to INFINITY
  m
end

def change_making(coins, n)
  m = get_change_making_matrix(coins, n)
  coins_used = Array.new(n + 1) { 0 }

  coins.each_with_index do |coin, c|
    (1..n).each do |r|
      if coin == r
        m[c + 1][r] = 1
        coins_used[r] = coin
      elsif coin > r
        m[c + 1][r] = m[c][r]
        coins_used[r] = coins_used[r]
      elsif m[c][r] <= 1 + m[c + 1][r - coin]
        m[c + 1][r] = m[c][r]
        coins_used[r] = coins_used[r]
      else
        m[c + 1][r] = 1 + m[c + 1][r - coin]
        coins_used[r] = coin
      end
    end
  end

  result = []
  current_value = n

  # Check if it's possible to make change
  return result if m[-1][-1] >= Float::INFINITY

  while current_value > 0
    result << coins_used[current_value]
    current_value -= coins_used[current_value]
  end

  result.reverse
end
