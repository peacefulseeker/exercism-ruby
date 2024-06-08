class Knapsack
  def initialize(max_weight)
    @max_weight = max_weight
  end

  def max_value(items)
    options = []
    1.upto(items.size) do |i|
      combinations = items.combination(i)
      combinations.each do |combination|
        weight = combination.sum(&:weight)
        options.push(combination) if weight <= @max_weight
      end
    end
    options.map { |i| i.sum(&:value) }.max || 0
  end
end
