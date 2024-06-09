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
