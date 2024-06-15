class Knapsack
  def initialize(max_weight)
    @max_weight = max_weight
  end

  def max_value(items)
    # need to flatten items returned by the combinations block
    # could also do options.flatten.max and do .map here
    1.upto(items.size)
     .flat_map { |i| suitable_combinations(i, items) }
     .max || 0
  end

  def suitable_combinations(index, items)
    # need to do extra manipulations to items that filtered before returning
    # summing the value in particular
    items.combination(index).filter_map(&method(:combination_value_sum))
  end

  def combination_value_sum(combination)
    combination.sum(&:value) if combination.sum(&:weight) <= @max_weight
  end
end

# TODO: not really grasped the idea. would need to spend more time
# on dynamic programming with memoization topic.
class KnapsackDynamic
  def initialize(max_weight)
    @max_weight = max_weight
  end

  def max_value(items)
    # e.g. max_values[3] is the maximum value so far for a maximum weight of 3.
    # create array with max_weight + 1 elements, filled with 0
    max_values = Array.new(@max_weight + 1, 0)

    items.each do |item|
      @max_weight.downto(item.weight) do |weight|
        value_with_item = max_values[weight - item.weight] + item.value

        # Include `item` only if doing so would increase the maximum value for this weight.
        max_values[weight] = [max_values[weight], value_with_item].max
      end
    end

    max_values[@max_weight]
  end
end
